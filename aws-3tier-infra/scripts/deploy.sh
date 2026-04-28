aws cloudformation deploy \
--template-file templates/main.yaml \
--stack-name prod-3tier \
--parameter-overrides file://parameters/prod.json \
--capabilities CAPABILITY_NAMED_IAM