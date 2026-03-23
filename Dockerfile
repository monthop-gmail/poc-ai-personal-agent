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

# สร้างโครงสร้างโฟลเดอร์
RUN mkdir -p /workspace/{notes,projects,downloads,research,scripts}

WORKDIR /workspace

# คัดลอกไฟล์ตั้งค่า agent
COPY CLAUDE.md .
COPY .claude/ .claude/

# volume สำหรับข้อมูลถาวร
VOLUME ["/workspace/notes", "/workspace/projects", "/workspace/research", "/workspace/scripts"]

CMD ["claude"]
