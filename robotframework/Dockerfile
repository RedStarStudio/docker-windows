#
# DERIVED FROM https://github.com/docker-library/python/blob/ac49e0bb09aafe4100fe5662636c24fce7206008/2.7/windows/windowsservercore-1709/Dockerfile
#

FROM microsoft/windowsservercore:10.0.14393.2665

COPY requirements.txt C:/ 

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV PYTHON_VERSION 2.7.15
ENV PYTHON_RELEASE 2.7.15

RUN $url = ('https://www.python.org/ftp/python/{0}/python-{1}.msi' -f $env:PYTHON_RELEASE, $env:PYTHON_VERSION); \
	Write-Host ('Downloading {0} ...' -f $url); \
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
	Invoke-WebRequest -Uri $url -OutFile 'python.msi'; \
	\
	Write-Host 'Installing ...'; \
# https://www.python.org/download/releases/2.4/msi/
	Start-Process msiexec -Wait \
		-ArgumentList @( \
			'/i', \
			'python.msi', \
			'/quiet', \
			'/qn', \
			'TARGETDIR=C:\Python', \
			'ALLUSERS=1', \
			'ADDLOCAL=DefaultFeature,Extensions,TclTk,Tools,PrependPath' \
		); \
	\
# the installer updated PATH, so we should refresh our local value
	$env:PATH = [Environment]::GetEnvironmentVariable('PATH', [EnvironmentVariableTarget]::Machine); \
	$env:PATHEXT = '.DLL;{0}' -f [Environment]::GetEnvironmentVariable('PATHEXT', [EnvironmentVariableTarget]::Machine); \
	\
	Write-Host 'Verifying install ...'; \
	Write-Host '  python --version'; python --version; \
	\
	Write-Host 'Removing ...'; \
	Remove-Item python.msi -Force; \
	\
	Write-Host 'Complete.';

# if this is called "PIP_VERSION", pip explodes with "ValueError: invalid truth value '<VERSION>'"
ENV PYTHON_PIP_VERSION 18.1

RUN Write-Host ('Installing pip=={0} ...' -f $env:PYTHON_PIP_VERSION); \
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
	Invoke-WebRequest -Uri 'https://bootstrap.pypa.io/get-pip.py' -OutFile 'get-pip.py'; \
	python get-pip.py \
		--disable-pip-version-check \
		--no-cache-dir \
		('pip=={0}' -f $env:PYTHON_PIP_VERSION) \
	; \
	Write-Host 'Verifying pip install ...'; \
	pip --version; \
	\
	Write-Host 'Removing ...'; \
	Remove-Item get-pip.py -Force; \
	\
	Write-Host 'Complete.';

# install robotframework and other libraries listed in requirements.txt
RUN Write-Host 'Installing robotframework and other libraries from requirements.txt ...'; \
    pip install -r requirements.txt;

ENTRYPOINT $env:PYTHONIOENCODING = 'UTF-8';