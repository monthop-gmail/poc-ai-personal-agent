FROM node:22-slim

# ติดตั้ง dependencies พื้นฐาน
RUN apt-get update && apt-get install -y \
    git \
    curl \
    jq \
    docker.io \
    && rm -rf /var/lib/apt/lists/*

# ติดตั้ง Claude Code
RUN npm install -g @anthropic-ai/claude-code

# สร้างโครงสร้างโฟลเดอร์ และให้ user node เป็นเจ้าของ
RUN mkdir -p /workspace/notes \
    /workspace/projects \
    /workspace/downloads \
    /workspace/research \
    /workspace/scripts \
    /home/node/.claude \
    && chown -R node:node /workspace /home/node/.claude

WORKDIR /workspace

# คัดลอกไฟล์ตั้งค่า agent
COPY --chown=node:node CLAUDE.md .
COPY --chown=node:node .claude/ .claude/

# Entrypoint สำหรับ setup credentials
COPY --chown=node:node entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# รันเป็น user node (ไม่ใช่ root)
USER node

ENTRYPOINT ["entrypoint.sh"]
CMD ["claude"]
