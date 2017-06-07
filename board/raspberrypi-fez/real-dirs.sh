# make real directories
function make_real_dir
{
  DIR="$1"

  if [ -h "${TARGET_DIR}${DIR}" ]; then
    echo "TARGET: replace ${TARGET_DIR}${DIR} as dir"
    rm -f "${TARGET_DIR}${DIR}"
    mkdir -p "${TARGET_DIR}${DIR}"
  fi

  if [ ! -d "${TARGET_DIR}${DIR}" ]; then
    echo "TARGET: create dir ${TARGET_DIR}${DIR}"
    mkdir -p "${TARGET_DIR}${DIR}"
  fi
}

# test for some key directories under rund
if [ `readlink "${TARGET_DIR}/sbin/init"` == "rund" ]; then
    make_real_dir /var/lib/misc
    make_real_dir /var/log/mosquitto
fi

make_real_dir /etc/dropbear
make_real_dir /etc/dropbear/remote
make_real_dir /boot