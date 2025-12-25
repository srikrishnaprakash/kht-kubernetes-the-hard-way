#!/bin/bash
certs=(
  "admin" "service-accounts"
  "kube-proxy" "kube-scheduler"
  "kube-api-server" "node-0"
  "kube-controller-manager"
)

for i in ${certs[*]}; do
	echo ${i}
	cnfFile="${i}.conf"
	echo "File  name is ${cnfFile} "
	keyFile="${i}.key"
	echo "File  name is ${keyFile} "
	csrFile="${i}.csr"
	echo "File  name is ${csrFile} "
	crtFile="${i}.crt"
	echo "File  name is ${crtFile} "
	openssl genrsa -out "${keyFile}" 4096
	openssl req -new -key "${i}.key" -sha256 \
		-config "${cnfFile}" -out "${i}.csr"
	res=$?
	if [[ ${res} == 0 ]]; then
		echo "${csrFile} generated..."
		openssl x509 -req -days 3650 -in  "${csrFile}" \
			-sha256 -CA "ca.crt" -CAkey "ca.key" \
			-extensions req_ext -extfile ${cnfFile} \
			-CAcreateserial -out "${crtFile}"
	fi
	res=$?
	echo "${res}. Picking up next..."
done

cp ca.key adm*.key kub*.key ser*.key nod*.key /root/
cp ca.crt adm*.crt kub*.crt ser*.crt nod*.crt  /root/
