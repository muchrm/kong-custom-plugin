FROM kong:0.11.2
ADD plugins /plugins
RUN cd /plugins && luarocks make