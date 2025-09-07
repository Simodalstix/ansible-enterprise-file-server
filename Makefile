.PHONY: bootstrap deploy health-check backup-test clean

# Main deployment commands
validate:
	ansible-playbook -i inventories/dev/hosts.yml playbooks/validate.yml

bootstrap: validate deploy health-check
	@echo "✅ Enterprise file server platform deployed successfully"

deploy:
	ansible-playbook -i inventories/dev/hosts.yml playbooks/site.yml

health-check:
	ansible-playbook -i inventories/dev/hosts.yml playbooks/health-check.yml

backup-test:
	ansible-playbook -i inventories/dev/hosts.yml playbooks/backup-test.yml

# Production deployment
prod-deploy:
	ansible-playbook -i inventories/prod/hosts.yml playbooks/site.yml

# Cloud Extensions
azure-deploy:
	ansible-galaxy install -r requirements.yml
	ansible-playbook -i inventories/dev/hosts.yml playbooks/site.yml
	ansible-playbook -i inventories/dev/hosts.yml playbooks/azure-extend.yml

aws-deploy:
	ansible-galaxy install -r requirements.yml
	ansible-playbook -i inventories/dev/hosts.yml playbooks/site.yml
	ansible-playbook -i inventories/dev/hosts.yml playbooks/aws-extend.yml

# VM Management
shutdown:
	ansible-playbook -i inventories/dev/hosts.yml playbooks/shutdown.yml

startup-check:
	ansible-playbook -i inventories/dev/hosts.yml playbooks/startup-check.yml

# Utility commands
clean:
	ansible-playbook -i inventories/dev/hosts.yml playbooks/cleanup.yml

cleanup-services:
	ansible-playbook -i inventories/dev/hosts.yml playbooks/cleanup.yml

syntax-check:
	ansible-playbook --syntax-check playbooks/site.yml

lint:
	ansible-lint playbooks/site.yml