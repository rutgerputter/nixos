userName="Mike Bearman"
userEmail="29874229+bearmannl@users.noreply.github.com"
authKeyPath=~/.ssh/authentication-github-bearmannl-$(hostname)
signKeyPath=~/.ssh/signing-github-bearmannl-$(hostname)
allowedSignersPath=~/.config/git/allowed_signers

echo "Git user.name: ${userName}"
echo "Git user.email: ${userEmail}"
git config --global user.name ${userName}
git config --global user.email ${userEmail}
echo " "

# Ensure the .ssh folder is available.
mkdir -p ~/.ssh
# Generate the authentication key.
echo "Authentication key path: ${authKeyPath}"
ssh-keygen -t ed25519 -C "${userEmail}" -f ${authKeyPath}
echo " "
# Add the signing key to the ssh-agent.
ssh-add ${authKeyPath}
echo " "
# Output the authentication public key, for uploading to GitHub.
cat ${authKeyPath}.pub
echo " "
echo "Copy the above public key content and add it to your SSH *authentication* keys here: https://github.com/settings/keys"
echo " "

# Ensure the .ssh and git config folders are available.
mkdir -p ~/.ssh
mkdir -p ~/.config
mkdir -p ~/.config/git
# Generate the signing key.
echo "Signing key path: ${signKeyPath}"
ssh-keygen -t ed25519 -C "${userEmail}" -f ${signKeyPath}
echo " "
git config --global user.signingkey ${signKeyPath}.pub
echo " "
cat ${signKeyPath}.pub
echo " "
echo "Copy the above public key content and add it to your SSH *signing* keys here: https://github.com/settings/keys"
echo " "
echo "Allowed signers path: ${allowedSignersPath}"
echo " "
echo "${userEmail} $(cat ${signKeyPath}.pub)" > ${allowedSignersPath}
echo " "
git config --global gpg.ssh.allowedSignersFile ${allowedSignersPath}
echo " "
