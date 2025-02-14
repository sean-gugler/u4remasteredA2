FROM python:3.6-slim-stretch

RUN apt-get update && apt-get install -y \
  build-essential \
  curl \
  unzip
  
RUN echo 'deb http://download.opensuse.org/repositories/home:/strik/Debian_10/ /' | tee /etc/apt/sources.list.d/home:strik.list
RUN curl -fsSL https://download.opensuse.org/repositories/home:strik/Debian_10/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/home_strik.gpg > /dev/null
 
RUN apt-get update && apt-get install -y \
  cc65 \
  && rm -rf /var/lib/apt/lists/*
  
COPY . /u4remasteredA2/

RUN curl -L -O https://archive.org/download/UltimaIV4amCrack/Ultima%20IV%20%284am%20crack%29.zip
RUN unzip Ultima%20IV%20%284am%20crack%29.zip
RUN mv Ultima\ IV\ \(4am\ crack\)/Ultima\ IV\ \(4am\ crack\)\ side\ C\ -\ Britannia.dsk u4remasteredA2/files/original/u4britannia.do
RUN mv Ultima\ IV\ \(4am\ crack\)/Ultima\ IV\ \(4am\ crack\)\ side\ A\ -\ Program.dsk u4remasteredA2/files/original/u4program.do
RUN mv Ultima\ IV\ \(4am\ crack\)/Ultima\ IV\ \(4am\ crack\)\ side\ B\ -\ Towne.dsk u4remasteredA2/files/original/u4towne.do
RUN mv Ultima\ IV\ \(4am\ crack\)/Ultima\ IV\ \(4am\ crack\)\ side\ D\ -\ Underworld.dsk u4remasteredA2/files/original/u4underworld.do

RUN sed --in-place 's/\r//g' u4remasteredA2/tools/extract_files.py
RUN sed --in-place 's/\r//g' u4remasteredA2/tools/binpatch.py
RUN sed --in-place 's/\r//g' u4remasteredA2/tools/dos33.py
RUN sed --in-place 's/\r//g' u4remasteredA2/tools/gen_talk.py

WORKDIR /u4remasteredA2

CMD ["make","all"]