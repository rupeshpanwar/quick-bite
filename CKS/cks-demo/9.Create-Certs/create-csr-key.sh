  openssl genrsa -out jane.key 2048
  openssl req -new -key jane.key -out jane.csr # only set Common Name = jane
  ls | grep jane
  vi csr.yml
  ls
  cat jane.csr | base -w 0
  cat jane.csr | base64 -w 0
  vi csr.yml
  cat csr.yml
  vi csr.yml
  k -f create csr.yml
  k -f csr.yml create
  k get csr
  k certificate approve jane
  k get csr
  k get csr jane -oy
  k config view
  k config set-context jane --cluster=kubernetes --user=jane
  k config view
  k config get-context
  k config get-contexts
  k config use-context jane
  k auth can-i delete deploy -A