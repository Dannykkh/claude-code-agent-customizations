# Claude Code Customizations

A comprehensive collection of custom Skills, Agents, Commands, Hooks, and MCP servers for Claude Code.

**[한국어 버전](README-ko.md)**

---

## Why This Project?

When using Claude Code, I found myself repeatedly:
- Setting up the same configurations for new projects
- Searching for useful external skills and plugins
- Writing similar agent prompts for common tasks

This repository solves these problems by:
1. **Centralizing configurations** - All customizations in one place
2. **Documenting external resources** - Curated list of useful skills, plugins, and MCP servers
3. **Project-type templates** - Quick setup guides for different tech stacks

---

## Quick Start

> **New environment?** See [SETUP.md](SETUP.md) for complete setup guide with project-type specific installations.

### Install by Project Type

| Project Type | Command |
|-------------|---------|
| **WPF / WinForms** | `npx add-skill Aaronontheweb/claude-code-dotnet -a claude-code` |
| **React / Next.js** | `npx add-skill vercel-labs/agent-skills -a claude-code` |
| **Node.js / NestJS** | `npx add-skill SpillwaveSolutions/mastering-typescript-skill -a claude-code` |
| **Payment Integration** | `claude mcp add tosspayments -- npx -y @tosspayments/integration-guide-mcp@latest` |

### Full Installation

```bash
# Windows
install.bat

# Linux/Mac
chmod +x install.sh && ./install.sh
```

---

## What's Included

### Custom Skills (Slash Commands)

| Skill | Command | Description |
|-------|---------|-------------|
| docker-deploy | `/docker-deploy` | Docker deployment environment setup |
| code-reviewer | `/code-reviewer` | Code review with compliance checks |
| react-best-practices | `/react-best-practices` | React performance optimization rules |
| web-design-guidelines | `/web-design-guidelines` | Web UI accessibility and UX review |

### Custom Agents (Subagents)

| Agent | Description |
|-------|-------------|
| api-tester | API endpoint testing and validation |
| code-reviewer | Code quality, security, and performance review |
| frontend-react | React component analysis and optimization |
| qa-engineer | QA verification and regression testing |
| qa-writer | Test scenario and test case writing |
| documentation | Technical documentation generation |
| migration-helper | Legacy to modern stack migration guide |

### Commands & Scripts

| Command | Description |
|---------|-------------|
| `/check-todos` | Review and prioritize TODO items |
| `/write-api-docs` | Generate API documentation |
| `/write-changelog` | Auto-generate changelog from git commits |
| `/write-prd` | Write Product Requirements Document |
| `/test` | Run tests and generate coverage report |
| `/review` | Perform code review |

### Hooks

| Hook | Timing | Description |
|------|--------|-------------|
| protect-files.sh | PreToolUse | Protect critical files from modification |
| format-code.sh | PostToolUse | Auto-format code after changes |
| validate-api.sh | PostToolUse | Validate API files after modification |

---

## External Resources (Recommended)

### Skills & Plugins

| Resource | Description | Install |
|----------|-------------|---------|
| [Vercel Agent Skills](https://github.com/vercel-labs/agent-skills) | React/Next.js best practices (45+ rules) | `npx add-skill vercel-labs/agent-skills -a claude-code` |
| [oh-my-claudecode](https://github.com/Yeachan-Heo/oh-my-claudecode) | 32 agents, 40+ skills, multi-agent orchestration | `/plugin install oh-my-claudecode` |
| [claude-code-dotnet](https://github.com/Aaronontheweb/claude-code-dotnet) | C#/WPF/MAUI/.NET skills | `npx add-skill Aaronontheweb/claude-code-dotnet -a claude-code` |
| [mastering-typescript-skill](https://github.com/SpillwaveSolutions/mastering-typescript-skill) | Enterprise TypeScript (NestJS, React 19) | `npx add-skill SpillwaveSolutions/mastering-typescript-skill -a claude-code` |
| [pg-aiguide](https://github.com/timescale/pg-aiguide) | PostgreSQL best practices | `claude plugin install pg-aiguide` |

### MCP Servers

| MCP | Description | Install |
|-----|-------------|---------|
| **[Toss Payments](https://toss.tech/article/tosspayments-mcp)** | Payment integration in 10 min (PG industry first) | `claude mcp add tosspayments -- npx -y @tosspayments/integration-guide-mcp@latest` |
| [Context7](https://github.com/upstash/context7) | Library documentation search | `claude mcp add context7 -- npx -y @upstash/context7-mcp` |
| [Playwright](https://github.com/microsoft/playwright-mcp) | Browser automation | `claude mcp add playwright -- npx -y @playwright/mcp@latest` |
| [Stitch](https://github.com/anthropics/stitch-mcp) | Google Stitch UI design | `npx -p stitch-mcp-auto stitch-mcp-auto-setup` |
| [GitHub](https://github.com/github/github-mcp-server) | GitHub API access | `claude mcp add github -- npx -y @modelcontextprotocol/server-github` |

---

## Project Structure

```
claude-code-customizations/
├── skills/                    # Custom skills (slash commands)
│   ├── docker-deploy/
│   ├── code-reviewer/
│   ├── react-best-practices/
│   ├── web-design-guidelines/
│   ├── api-tester/
│   ├── erd-designer/
│   └── python-backend/
├── agents/                    # Custom subagents
│   ├── api-tester.md
│   ├── code-reviewer.md
│   ├── frontend-react.md
│   ├── qa-engineer.md
│   ├── qa-writer.md
│   ├── documentation.md
│   └── migration-helper.md
├── commands/                  # Slash commands & scripts
│   ├── check-todos.md
│   ├── write-api-docs.md
│   ├── write-changelog.md
│   ├── write-prd.md
│   ├── test.md
│   └── review.md
├── hooks/                     # Hook scripts
│   ├── protect-files.sh
│   ├── format-code.sh
│   └── validate-api.sh
├── mcp-servers/               # MCP server guides
│   ├── README.md
│   └── claude-orchestrator-mcp/
├── install.bat                # Windows installer
├── install.sh                 # Linux/Mac installer
├── SETUP.md                   # Complete setup guide
├── README.md                  # This file (English)
└── README-ko.md               # Korean version
```

---

## Installation Locations

| Item | Global | Project |
|------|--------|---------|
| Skills | `~/.claude/skills/` | `.claude/skills/` |
| Agents | `~/.claude/agents/` | `.claude/agents/` |
| Commands | - | `.claude/commands/` |
| Hooks | `~/.claude/settings.json` | `.claude/settings.json` |

- **Global**: Available in all projects
- **Project**: Available only in that project

---

## Adding New Customizations

### Add a new skill
```bash
mkdir skills/my-skill
# Create skills/my-skill/SKILL.md
```

### Add a new agent
```bash
# Create agents/my-agent.md
```

### Add a new command
```bash
# Create commands/my-command.md
```

---

## Related Resources

| Project | Description | Link |
|---------|-------------|------|
| awesome-claude-code-subagents | 100+ specialized subagents | [GitHub](https://github.com/VoltAgent/awesome-claude-code-subagents) |
| awesome-claude-skills | Curated Claude skills list | [GitHub](https://github.com/travisvn/awesome-claude-skills) |
| everything-claude-code | Anthropic hackathon winner setup | [GitHub](https://github.com/affaan-m/everything-claude-code) |
| claude-code-showcase | Comprehensive config examples | [GitHub](https://github.com/ChrisWiles/claude-code-showcase) |
| awesome-claude-code | Claude Code resource curation | [GitHub](https://github.com/hesreallyhim/awesome-claude-code) |

---

## License

MIT License

---

**Last Updated:** 2026-01-25
