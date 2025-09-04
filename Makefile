.PHONY: bootstrap deploy health-check backup-test clean

# Main deployment commands
bootstrap: deploy health-check
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

# Utility commands
clean:
	ansible-playbook -i inventories/dev/hosts.yml playbooks/cleanup.yml

syntax-check:
	ansible-playbook --syntax-check playbooks/site.yml

lint:
	ansible-lint playbooks/site.yml