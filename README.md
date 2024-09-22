# Backup Script

This script creates a backup of a given directory or file with optional compression and encryption. It supports various compression algorithms and encrypts the backup archive using AES-256-CBC.

## Usage

```
./backup.sh [FILE/DIRECTORY] [ALGORITHM] [OUTPUT FILE]
```

### Arguments

- `FILE/DIRECTORY`: The file or directory to backup.
- `ALGORITHM`: The compression algorithm to use. Available options:
  - `none`: No compression, just creates a tar archive.
  - `gzip`: Compresses the archive using gzip.
  - `bzip2`: Compresses the archive using bzip2.
- `OUTPUT FILE`: The name of the output archive file without extension. The script will add appropriate extensions based on the chosen compression algorithm.

### Example

Backup a file with gzip compression:

```
./backup.sh dummy.txt gzip backup_dummy
```

Backup a directory without compression:

```
./backup.sh /myfolder none backup_folder
```

### Encryption

The script uses `openssl enc -aes-256-cbc` to encrypt the resulting archive. During the backup process, you will be prompted to enter and verify a password for encryption. 

### Decryption and Extraction

To decrypt and extract the backup archive:

1. Use `openssl` to decrypt the file:

```
openssl enc -d -aes-256-cbc -pbkdf2 -in [ENCRYPTED_FILE] -out [DECRYPTED_ARCHIVE]
```

2. Extract the decrypted tar file:

```
tar -xzf [DECRYPTED_ARCHIVE]
```

Where:
- `[ENCRYPTED_FILE]` is your encrypted file (e.g., `backup_dummy.enc`).
- `[DECRYPTED_ARCHIVE]` is the decrypted archive (e.g., `backup_dummy.tar.gz`).
