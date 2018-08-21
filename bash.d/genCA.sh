#!/bin/bash
#--------------------------------------------------
# File Name: ${FILE_NAME}
# Author: hanxu
# AuthorSite: https://www.thesunboy.com/
# Created Time: 2018-07-10 上午11:46
#---------------------说明--------------------------
#  生成本地CA证书
#---------------------------------------------------
#以上命令中 -subj 参数里的 /C 表示国家，
#如 CN；/ST 表示省；/L 表示城市或者地区；
#/O 表示组织名；/CN 通用名称。

workDir=$(pwd);
keyname=;
domain=;
subject="/C=CN/ST=hunan/L=chansha/O=mycompany/CN=copylight by hanxu.thesunboy.com";
function init(){
    if [ ! -d ${tmpDir} ]; then
         mkdir ${tmpDir} && cd ${tmpDir} || exit 1;
         return 0;
    fi
    keyname=$1;
    domain=$1;

#    local tmpDir="/tmp/buildCA/";
#    workDir=${tmpDir};

    if [ ! -d ${workDir} ]; then
        mkdir ${workDir};
    fi

}
#第一步创建 CA 私钥
#第二步利用私钥创建 CA 根证书请求文件
function genKeyAndCsr(){
    echo "genKeyAndCsr>>>";
    openssl genrsa -out "${keyname}.root.key" 4096;
#    echo sss$?
#    if [[ $? -eq "0" ]]; then
    openssl req -new -key "${keyname}.root.key" -out "${keyname}.root.csr" -sha256 -subj "${subject}";
#    fi
    echo "genKeyAndCsr<<<:$?";
}


#第三步配置 CA 根证书，新建 root-ca.cnf。
function genCAcnf(){
    echo "genCAcnf>>>";

    cnftxt="[root_ca]
basicConstraints = critical,CA:TRUE,pathlen:1
keyUsage = critical, nonRepudiation, cRLSign, keyCertSign
subjectKeyIdentifier=hash";
    echo "${cnftxt}" > ${workDir}/${keyname}.root.cnf;
    echo "genCAcnf<<<:$?";
}

#第四步签发根证书。
function genCrt(){
    echo "genCrt>>>";

    openssl x509 -req  -days 3650  -in "${keyname}.root.csr" \
               -signkey "${keyname}.root.key" -sha256 -out "${keyname}.root.crt" \
               -extfile "${keyname}.root.cnf" -extensions root_ca
    echo "genCrt<<<:$?";
}
#第七步配置证书，新建 site.cnf 文件。
function gensiteCnf(){
    local sitecnf="[server]
authorityKeyIdentifier=keyid,issuer
basicConstraints = critical,CA:FALSE
extendedKeyUsage=serverAuth
keyUsage = critical, digitalSignature, keyEncipherment
subjectAltName = DNS:${domain}
subjectKeyIdentifier=hash";
    echo "${sitecnf}" >> ${workDir}/${keyname}.site.cnf
}

case $1 in
    "init")
        shift;
        params=$@;
        init $params;
    ;;
    "cnf")
        shift;
        params=$@;
         init $params;
        genCAcnf $params;
    ;;
    "gen")
        shift;
        params=$@;
        init $params;
        genKeyAndCsr;
        genCAcnf;
        genCrt;

#        第五步生成站点 SSL 私钥
        openssl genrsa -out "${keyname}.domain.key" 4096
#        第六步使用私钥生成证书请求文件
        openssl req -new -key "${keyname}.domain.key" -out "${keyname}.site.csr" -sha256 -subj "${subject}";
        gensiteCnf;

        openssl x509 -req -days 750 -in "${keyname}.site.csr" -sha256 \
    -CA "${keyname}.root.crt" -CAkey "${keyname}.root.key"  -CAcreateserial \
    -out "${domain}.domain.crt" -extfile "${keyname}.site.cnf" -extensions server

    ;;
    "apply")
        shift;
        params=$@;
        init $params;
        mkdir -p /etc/docker/certs.d/${keyname}
        if [ -d "/etc/docker/certs.d/${keyname}/" -a -f "${workDir}/${keyname}.domain.crt" ]; then
             cp ${workDir}/${keyname}.domain.* /etc/docker/certs.d/${keyname}/
        fi

        ;;

esac