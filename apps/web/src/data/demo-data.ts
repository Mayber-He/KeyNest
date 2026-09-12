export type VaultItemKind = 'login' | 'api-key'

export interface VaultItem {
  readonly id: string
  readonly name: string
  readonly kind: VaultItemKind
  readonly account: string
  readonly website: string
  readonly secret: string
  readonly updatedAt: string
}

export interface Device {
  readonly id: string
  readonly name: string
  readonly platform: string
  readonly location: string
  readonly lastActive: string
  readonly current: boolean
}

export const vaultItems = [
  {
    id: 'github-example',
    name: 'GitHub',
    kind: 'login',
    account: 'octocat@example.com',
    website: 'https://github.com',
    secret: 'public-demo-password',
    updatedAt: '今天 09:42',
  },
  {
    id: 'openai-example',
    name: 'OpenAI',
    kind: 'api-key',
    account: 'Demo Project',
    website: 'https://platform.openai.com',
    secret: 'sk-example-public-not-a-real-key',
    updatedAt: '昨天 18:20',
  },
  {
    id: 'google-example',
    name: 'Google',
    kind: 'login',
    account: 'demo.user@example.com',
    website: 'https://accounts.google.com',
    secret: 'example-only-password',
    updatedAt: '9 月 8 日',
  },
] as const satisfies readonly VaultItem[]

export const devices = [
  {
    id: 'macbook-example',
    name: '示例 MacBook Pro',
    platform: 'macOS · 桌面端',
    location: '上海',
    lastActive: '当前设备',
    current: true,
  },
  {
    id: 'iphone-example',
    name: '示例 iPhone',
    platform: 'iOS · 移动端',
    location: '上海',
    lastActive: '2 小时前',
    current: false,
  },
  {
    id: 'windows-example',
    name: '示例 Windows 电脑',
    platform: 'Windows · 桌面端',
    location: '杭州',
    lastActive: '3 天前',
    current: false,
  },
] as const satisfies readonly Device[]
