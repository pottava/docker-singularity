#!/bin/bash

# Set a proper group
group=$(getent group "$(id -g)" | awk -F: '{print $1}')
if [[ -n "${GID}" ]]; then
  candidate=$(getent group "${GID}" | awk -F: '{print $1}')
  if [[ -z "${candidate}" ]]; then
    groupadd -g "${GID}" singularity
    group=singularity
  else
    group="${candidate}"
  fi
fi

# Set a proper user
user=$(getent passwd "$(id -u)" | awk -F: '{print $1}')
if [[ -n "${UID}" ]]; then
  candidate=$(getent passwd "${UID}" | awk -F: '{print $1}')
  if [[ -z "${candidate}" ]]; then
    useradd -u "${UID}" -g "${group}" -s /bin/bash singularity
    user=singularity
  else
    user="${candidate}"
  fi
fi

if [[ "$1" == 'sh' ]]; then
  exec gosu "${user}" "$@"
fi
if [[ "$1" == 'bash' ]]; then
  exec gosu "${user}" "$@"
fi

exec gosu "${user}" singularity "$@"
