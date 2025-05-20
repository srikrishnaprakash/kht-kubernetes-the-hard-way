#!/bin/bash
certs=(
  "ca" "admin" "service-accounts"
  "kube-proxy" "kube-scheduler"
  "kube-api-server" "node-0"
  "kube-controller-manager"
)


for i in ${certs[*]}; do
  echo "Generating key for ${i}..."
  cnfFile="${i}.conf"
  keyFile="${i}.key"
  csrFile="${i}.csr"
  crtFile="${i}.crt"
  openssl genrsa -out "${keyFile}" 2048
  echo "Generating csr for ${i} using ${c_file}..."
  openssl req -new -key "${keyFile}" -out "${csrFile}" -config ${cnfFile}
  res=$?
  echo "${res}..."
  if [[ ${i} == "ca" && ${res} == 0 ]]; then 
    echo "Generating crt for root ca..."
    openssl req -x509 -new -sha512 -noenc -key "${keyFile}" -days 365 -config ${cnfFile} -out "${crtFile}"
  elif [[ ${res} == 0 ]]; then
    echo "Generating crt for ${i}..."
    openssl x509 -req -days 365 -in  "${csrFile}" \
      -sha256 -CA "ca.crt" -CAkey "ca.key" \
      -extensions req_ext -extfile ${cnfFile} \
      -CAcreateserial -out "${crtFile}"
  fi
  res=$?
  echo "${res}k. Picking up next..."
done
mv *.key ../certs/
mv *.csr ../certs/
mv *.crt ../certs/
mv *.srl ../certs/