%global cartridgedir %{_libexecdir}/openshift/cartridges/liberty

Name:		openshift-origin-cartridge-liberty
Version:	0.0.1
Release:	1%{?dist}
Summary:	Liberty cartridge
Group:		Development/Languages
License:	ASL 2.0
URL:		https://github.com/WASdev/cloud.openshift.cartridge.wlp
Source0:	%{name}-%{version}.tar.gz
Requires:	rubygem(openshift-origin-node)
Requires:	openshift-origin-node-util
Requires:	java-1.7.0-openjdk
Requires:	java-1.7.0-openjdk-devel
%if 0%{?rhel}
Requires:	maven3
%endif
%if 0%{?fedora}
Requires:	maven
%endif
BuildRequires:	jpackage-utils
BuildArch:	noarch

%description
Openshift Cartridge for the WebSphere Liberty Profile (Cartridge Format V2)

%prep
%setup -q

%build
%__rm %{name}.spec

%install
%__mkdir -p %{buildroot}%{cartridgedir}
%__cp -r * %{buildroot}%{cartridgedir}

%post
%if 0%{?rhel}
alternatives --install /etc/alternatives/maven-3.0 maven-3.0 /usr/share/java/apache-maven-3.0.3 100
alternatives --set maven-3.0 /usr/share/java/apache-maven-3.0.3
%endif

%if 0%{?fedora}
alternatives --remove maven-3.0 /usr/share/java/apache-maven-3.0.3
alternatives --install /etc/alternatives/maven-3.0 maven-3.0 /usr/share/maven 102
alternatives --set maven-3.0 /usr/share/maven
%endif

%clean
rm -rf %{buildroot}


%files
%dir %{cartridgedir}
%attr(0755,-,-) %{cartridgedir}/bin/
%{cartridgedir}/env/
%{cartridgedir}/metadata/
%{cartridgedir}/template/
%{cartridgedir}/versions/
%doc %{cartridgedir}/README.md
%doc %{cartridgedir}/CONTRIBUTING.md
%doc %{cartridgedir}/LICENSE
%doc %{cartridgedir}/ibm-websphere-liberty-buildpack/
%doc %{cartridgedir}/cache/

%changelog
* Wed Jan 07 2015 Michael Peters <mtpeters@us.ibm.com> - 0.0.1-1
- initial spec file

