  236  allow.yaml
  237  vi allow.yml
  238  k -f allow.yaml create
  239  k -f allow.yml create
  240  vi deny.yml
  241  k -f deny.yml create
  242  k exec nginx -it -- bash
  243  k get pod --show-labels
  244  k label pod nginx role=metadata-accessor
  245  k get pod --show-labels
  246  k exec nginx -it -- bash