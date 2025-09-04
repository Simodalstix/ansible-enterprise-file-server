# Enterprise File Server Platform - Ansible Project

🎯 **Production-ready enterprise file server with Active Directory integration**

## Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   File Server   │    │  Backup Server  │    │ Client Station  │
│  (4GB RAM)      │    │   (2GB RAM)     │    │   (2GB RAM)     │
│                 │    │                 │    │                 │
│ • Samba + AD    │◄──►│ • Rsync Backup  │    │ • Autofs Client │
│ • NFS Server    │    │ • Monitoring    │    │ • Auto-mount    │
│ • Monitoring    │    │ • Retention     │    │ • Testing       │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
                    ┌─────────────────┐
                    │ Active Directory│
                    │ 192.168.198.10  │
                    │  simo.local     │
                    └─────────────────┘
```

## Quick Start

```bash
# Deploy entire platform
make bootstrap

# Production deployment
make prod-deploy

# Health checks
make health-check

# Test backups
make backup-test
```

## Features

### 🔐 Security & Integration
- **Active Directory Integration**: Seamless SSO with existing AD (simo.local)
- **Kerberos Authentication**: Secure NFS with krb5p
- **SMB Signing**: Mandatory signing for data integrity
- **Firewall Configuration**: Automated UFW rules

### 📁 File Services
- **Samba Shares**: AD-integrated SMB/CIFS shares
- **NFS Exports**: High-performance NFS with security
- **Autofs**: Seamless auto-mounting on clients
- **User Quotas**: Automated quota management

### 💾 Backup & Monitoring
- **Automated Backups**: Daily rsync with 30-day retention
- **Storage Monitoring**: Disk usage and quota alerts
- **Service Health**: Automated service status checks
- **Log Management**: Centralized logging for all components

## Configuration

### Environment Variables
```yaml
# Active Directory
ad_domain: simo.local
ad_server: 192.168.198.10

# Storage
storage_root: /srv/shares
quota_soft_limit: 1G
quota_hard_limit: 2G

# Security
smb_signing: mandatory
nfs_security: krb5p
```

### Network Requirements
- **File Server**: 192.168.198.20 (4GB RAM)
- **Backup Server**: 192.168.198.21 (2GB RAM)  
- **Client Station**: 192.168.198.22 (2GB RAM)
- **AD Server**: 192.168.198.10 (existing)

## Project Structure

```
ansible-enterprise-file-server/
├── inventories/
│   ├── dev/hosts.yml         # Development environment
│   └── prod/hosts.yml        # Production environment
├── roles/
│   ├── common/               # Base system setup
│   ├── samba/               # SMB/CIFS + AD integration
│   ├── nfs-server/          # NFS exports with Kerberos
│   ├── autofs/              # Client auto-mounting
│   ├── backup/              # Automated backup system
│   └── monitoring/          # Storage monitoring & quotas
├── playbooks/
│   ├── site.yml             # Main deployment
│   ├── health-check.yml     # System validation
│   └── backup-test.yml      # Backup verification
├── group_vars/all.yml       # Global configuration
├── Makefile                 # Automation commands
└── README.md               # This file
```

## Deployment Process

1. **Infrastructure Setup**: Base packages, firewall, NTP
2. **AD Integration**: Join domain, configure Kerberos
3. **File Services**: Configure Samba and NFS with security
4. **Client Setup**: Install and configure autofs
5. **Backup System**: Automated rsync with retention
6. **Monitoring**: Quota management and health checks

## Validation

### Health Checks
```bash
# Service status
systemctl status smbd nfs-kernel-server winbind

# AD connectivity
wbinfo -t

# Mount testing
ls /mnt/shares/shared
```

### Backup Verification
```bash
# Manual backup test
/usr/local/bin/backup.sh

# Check latest backup
ls -la /srv/backups/latest
```

## Security Considerations

- **Domain Membership**: File server joins AD as member (not controller)
- **Encrypted Communication**: Kerberos for NFS, SMB signing enabled
- **Access Control**: AD groups control file permissions
- **Firewall Rules**: Only required ports (22, 445, 2049) open
- **Quota Enforcement**: Prevents storage abuse

## Troubleshooting

### Common Issues
```bash
# AD join issues
realm list
kinit administrator@SIMO.LOCAL

# NFS mount problems
showmount -e file-server
rpcinfo -p file-server

# Samba connectivity
smbclient -L file-server -U administrator
```

### Log Locations
- **Samba**: `/var/log/samba/`
- **NFS**: `/var/log/kern.log`
- **Backup**: `/var/log/backup.log`
- **Storage**: `/var/log/storage.log`

## Enterprise Value

✅ **Production Ready**: Proper error handling, idempotency, security hardening  
✅ **Scalable Design**: Role-based architecture following SRP  
✅ **Integration Focus**: Works with existing AD infrastructure  
✅ **Automation**: Single-command deployment and testing  
✅ **Monitoring**: Proactive storage and service monitoring  

Perfect demonstration of enterprise storage expertise with modern DevOps practices! 🚀