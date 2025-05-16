authKeyPath=~/.ssh/authentication-github-bearmannl-$(hostname)

echo "Authentication key path: ${authKeyPath}"
echo " "
# Add the signing key to the ssh-agent.
ssh-add ${authKeyPath}
echo " "
