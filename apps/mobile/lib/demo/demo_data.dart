class DemoVaultItem {
  const DemoVaultItem({
    required this.name,
    required this.type,
    required this.subtitle,
    required this.value,
  });

  final String name;
  final String type;
  final String subtitle;
  final String value;
}

class DemoDevice {
  const DemoDevice({
    required this.name,
    required this.lastSeen,
    required this.isCurrent,
  });

  final String name;
  final String lastSeen;
  final bool isCurrent;
}

const demoVaultItems = [
  DemoVaultItem(
    name: 'GitHub',
    type: '登录',
    subtitle: 'github.com',
    value: 'github-demo-password',
  ),
  DemoVaultItem(
    name: 'OpenAI',
    type: 'API Key',
    subtitle: 'api.openai.com',
    value: 'sk-public-example',
  ),
  DemoVaultItem(
    name: 'Google',
    type: '登录',
    subtitle: 'accounts.google.com',
    value: 'google-demo-password',
  ),
];

const demoDevices = [
  DemoDevice(name: 'iPhone 15 Pro', lastSeen: '刚刚活跃', isCurrent: true),
  DemoDevice(name: 'MacBook Air', lastSeen: '昨天活跃', isCurrent: false),
];
