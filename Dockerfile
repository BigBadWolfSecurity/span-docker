FROM fedora:34

LABEL maintainer="karl@bigbadwolfsecurity.com"

RUN useradd span
WORKDIR /home/span

RUN dnf -y install policycoreutils libselinux-devel libsepol-devel \
    python3 @development-tools flex bison python3-devel git pandoc

ADD requirements.txt .

RUN pip3 install -r requirements.txt

RUN git clone https://github.com/SELinuxProject/setools.git

WORKDIR /home/span/setools

RUN python3 setup.py install

WORKDIR /home/span

USER span

RUN git clone https://github.com/BigBadWolfSecurity/SPAN.git

WORKDIR /home/span/SPAN

USER root

RUN pip3 install -r python_requirements.txt

USER span

CMD ["jupyter", "notebook", "--ip=0.0.0.0"]