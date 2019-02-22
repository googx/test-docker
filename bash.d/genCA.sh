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
#TODO 需要解决的问题有 使用证书携带自定义参数信息如何实现? 参考 -extfile "${rootkeyname}.root.cnf" -extensions root_ca选项如何设置.
#TODO 如何为安装包实现 数字签名证书.
#*.key：密钥文件，一般是SSL中的私钥；
#
#　　　　*.csr：证书请求文件，里面包含公钥和其他信息，通过签名后就可以生成证书；
#
#　　　　*.crt, *.cert：证书文件，包含公钥，签名和其他需要认证的信息，比如主机名称（IP）等。
#
#　　　　*.pem：里面一般包含私钥和证书的信息。

workDir=$(pwd);
rootkeyname="thesunboy.com";
keyname="";
domain="";
rootSubject="/C=CN/ST=hunan/L=chansha/O=TheSunBoy/CN=hanxu Root CA";
siteSubject="/C=CN/ST=hunan/L=chansha/O=TheSunBoy/CN=test.thesunboy.com/";
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
function genCArootKeyAndCsr(){
    echo "genCArootKeyAndCsr>>>";
    openssl genrsa -out "${rootkeyname}.root.key" 4096;
#    echo sss$?
#    if [[ $? -eq "0" ]]; then
    openssl req -new -key "${rootkeyname}.root.key" -out "${rootkeyname}.root.csr" -sha256 -subj "${rootSubject}";
#    fi
    echo "genCArootKeyAndCsr<<<:$?";
}


#第三步配置 CA 根证书，新建 root-ca.cnf。
function genCArootCnf(){
    echo "genCAcnf>>>";

    cnftxt="[root_ca]
basicConstraints = critical,CA:TRUE,pathlen:1
keyUsage = critical, nonRepudiation, cRLSign, keyCertSign
subjectKeyIdentifier=hash";
    echo "${cnftxt}" > ${workDir}/${keyname}.root.cnf;
    echo "genCAcnf<<<:$?";
}

#第四步签发根证书。
function genCArootCrt(){
    echo "genRootCrt>>>";

    openssl x509 -req  -days 3650  -in "${rootkeyname}.root.csr" \
               -signkey "${rootkeyname}.root.key" -sha256 -out "${rootkeyname}.root.crt" \
               -extfile "${rootkeyname}.root.cnf" -extensions root_ca
    echo "genRootCrt<<<:$?";
}

#第五步生成站点 SSL 私钥
function genSiteSSLkey(){
        openssl genrsa -out "${keyname}.site.key" 4096
}

#第六步使用私钥生成证书请求文件
function genSiteSSLcsr() {
    openssl req -new -key "${keyname}.site.key" -out "${keyname}.site.csr" -sha256 -subj "${siteSubject}";
}

#第七步配置证书，新建 site.cnf 文件。
function genSiteSslCnf(){
    local sitecnf="[server]
authorityKeyIdentifier=keyid,issuer
basicConstraints = critical,CA:FALSE
extendedKeyUsage=serverAuth
keyUsage = critical, digitalSignature, keyEncipherment

subjectAltName = DNS:${domain}
subjectKeyIdentifier=hash";
    echo "${sitecnf}" >> ${workDir}/${keyname}.site.cnf
}

#第八步签署站点 SSL 证书。
function genSiteSslCrt(){
    openssl x509 -req -days 750 -in "${keyname}.site.csr" -sha256 \
    -CA "${rootkeyname}.root.crt" -CAkey "${rootkeyname}.root.key"  -CAcreateserial \
    -out "${domain}.site.crt" -extfile "${keyname}.site.cnf" -extensions server
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
        genCArootCnf $params;
    ;;
    "gen")
        shift;
        params=$@;
        init $params;
#        genCArootKeyAndCsr;
#        genCArootCnf;
#        genCArootCrt;
        genSiteSSLkey;
        genSiteSSLcsr;
        genSiteSslCnf;
        genSiteSslCrt;

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
