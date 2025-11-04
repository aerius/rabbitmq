FROM rabbitmq:4.0.5-management

RUN rabbitmq-plugins enable --offline rabbitmq_event_exchange rabbitmq_prometheus

# Defaults, override when needed.
ENV AERIUS_RABBITMQ_USER="aerius" \
    AERIUS_RABBITMQ_PASSWORD="aerius" \
    # Disable acknowledgment timeout
    AERIUS_RABBITMQ_CONSUMER_TIMEOUT="undefined" \
    # Set max message size to the max possible by default
    AERIUS_RABBITMQ_MAX_MESSAGE_SIZE="536870912" \
    # Set memory RabbitMQ should use to a higher value by default (it's a fraction!)
    AERIUS_RABBITMQ_VM_MEMORY_HIGH_WATERMARK="0.8" \
    # Set RabbitMQ default stream type. Can still be overwritten by the taskmanager if needed
    RABBITMQ_DEFAULT_QUEUE_TYPE="quorum" \
    # Enable feature flags. When added one the defaults will be disabled. Take this into consideration when updating to a new version (e.g.: Check for new features!)
    RABBITMQ_FEATURE_FLAGS="rabbit_exchange_type_local_random,rabbitmq_4.0.0,message_containers_deaths_v2,quorum_queue_non_voters,detailed_queues_endpoint,khepri_db"

# Override with our own entrypoint that will set the appropriate settings on container start
COPY aerius-docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["aerius-docker-entrypoint.sh"]
CMD ["rabbitmq-server"]
