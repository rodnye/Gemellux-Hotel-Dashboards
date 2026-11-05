FROM grafana/grafana:12.1.0

ENV GF_SECURITY_ADMIN_USER=gemellux \
    GF_SECURITY_ADMIN_PASSWORD=gemellux \
    GF_USERS_ALLOW_SIGN_UP=false

COPY --chown=grafana:grafana provisioning/ /etc/grafana/provisioning/

EXPOSE 3000
