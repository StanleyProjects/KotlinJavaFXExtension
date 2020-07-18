FROM kepocnhh/debianex-jdk14.0.1-gradle6.5:0.0.1

COPY . /build
WORKDIR /build

RUN ls ./buildSrc/src/main/resources/script
RUN stat -c %A ./buildSrc/src/main/resources/script/pipeline.sh
RUN ./buildSrc/src/main/resources/script/pipeline.sh
