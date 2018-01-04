FROM kong:0.11.2
RUN yum install -y unzip
ADD plugins /plugins
RUN cd /plugins && luarocks make