#!/usr/bin/env bash

# consumer_timeout cannot be set in the default config to unlimited and I refuse to set a very very high timeout because of this
export RABBITMQ_SERVER_ADDITIONAL_ERL_ARGS="-rabbit consumer_timeout \"${AERIUS_RABBITMQ_CONSUMER_TIMEOUT}\""

# Write options to config file
cat << EOF > /etc/rabbitmq/conf.d/99-aerius_overrides.conf
default_user = ${AERIUS_RABBITMQ_USER}
default_pass = ${AERIUS_RABBITMQ_PASSWORD}

max_message_size = ${AERIUS_RABBITMQ_MAX_MESSAGE_SIZE}

vm_memory_high_watermark.relative = ${AERIUS_RABBITMQ_VM_MEMORY_HIGH_WATERMARK}

default_queue_type = ${RABBITMQ_DEFAULT_QUEUE_TYPE}

EOF

# Execute default entrypoint
/usr/local/bin/docker-entrypoint.sh "${@}"
