
### Steps to Link `.vimrc` to a New Session via Git (SSH)

1. **Ensure SSH key setup** (if not done already):
   - Generate an SSH key:
     ```bash
     ssh-keygen -t ed25519 -C "your_email@example.com"
     ```
     Follow the prompts to save the key (typically to `~/.ssh/id_ed25519`).
   - Copy the public SSH key to your clipboard:
     ```bash
     cat ~/.ssh/id_ed25519.pub
     ```
   - Add the SSH key to your GitHub account under `Settings -> SSH and GPG keys`.

2. **Navigate to your home directory**:
   ```bash
   cd ~
   ```

3. **Initialize Git in the home directory (if it's not initialized)**:
   ```bash
   git init
   ```

4. **Add the SSH remote for your Vim configuration repository**:
   If the remote already exists, skip this step.
   ```bash
   git remote add origin git@github.com:jeportie/vimrc.git
   git remote -v
   ```

5. **Pull the repository**:
   To sync your `.vimrc` file to the new session:
   ```bash
   git pull origin master
   ```
   If you encounter untracked file conflicts, back them up or remove them as explained earlier.


7. **Stage, commit, and push changes** (when making updates):
   - Add and commit changes:
     ```bash
     git add .vimrc
     git commit -m "Updated .vimrc"
     ```
   - Push changes to GitHub:
     ```bash
     git push origin master
     ```
---

### Key Notes:
- **Use SSH** for secure Git operations.
- **Pull updates** whenever you start a new session on a fresh machine to keep your `.vimrc` in sync.
- **Only track necessary files** using `.gitignore` to prevent clutter.
