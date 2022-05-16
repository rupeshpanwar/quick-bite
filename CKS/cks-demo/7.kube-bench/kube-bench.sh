    kubectl version
    # run on master
    docker run --pid=host -v /etc:/etc:ro -v /var:/var:ro -t aquasec/kube-bench:latest run --targets=master --version 1.23
    ps -ef | grep etcd
    stat -c %U:%G /var/lib/etcd
    useradd etcd
    chown etcd:etcd /var/lib/etcd
    docker run --pid=host -v /etc:/etc:ro -v /var:/var:ro -t aquasec/kube-bench:latest run --targets=master --version 1.23

    # run on worker
docker run --pid=host -v /etc:/etc:ro -v /var:/var:ro -t aquasec/kube-bench:latest run --targets=node --version 1.23

# now for container ..checking hash
    tar xzf kubernetes-server-linux-amd64.tar.gz 
    ls
    ls kubernetes/server/bin
    kubernetes/server/bin/kube-apiserver --version
    k -n kube-system get pod | grep api
    k -n kube-system get pod kube-apiserver-cks-master -oyaml | grep image
    sha512sum kubernetes/server/bin/kube-apiserver
    crictl ps | grep api
    ps aux | grep kube-api-server
    ls /proc/7339/root/
    find /proc/7339/root/ | grep kube-api
    sha512sum /proc/7339/root/usr/local/bin/kube-apiserver
