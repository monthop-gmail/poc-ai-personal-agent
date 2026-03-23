# Checklist: สร้าง AI Personal Agent ด้วย Claude Code

คู่มือสำหรับใครที่อยากสร้าง AI Personal Agent ของตัวเอง ใช้เป็น checklist ทำทีละขั้น

---

## 1. พื้นฐาน (Foundation)

- [ ] สร้างโฟลเดอร์โปรเจค
- [ ] `git init` และเชื่อมกับ remote repo
- [ ] สร้างไฟล์ `CLAUDE.md` — กำหนดบทบาท, บุคลิก, ภาษาที่ใช้
- [ ] ตั้งค่า `.claude/settings.local.json` — กำหนดสิทธิ์ (allow/deny)

## 2. โครงสร้างโฟลเดอร์ (Folder Structure)

- [ ] วางโครงสร้างโฟลเดอร์ให้ชัดเจน เช่น:
  - [ ] `notes/` — โน้ตส่วนตัว
  - [ ] `projects/` — โปรเจคทั้งหมด
  - [ ] `research/` — ผลการค้นคว้า
  - [ ] `downloads/` — ไฟล์ชั่วคราว
  - [ ] `scripts/` — สคริปต์ที่ใช้บ่อย
- [ ] เขียนกฎการจัดการโฟลเดอร์ใน `CLAUDE.md` — ให้ agent รู้ว่าอะไรวางที่ไหน

## 3. คำสั่งลัด (Slash Commands)

สร้างไฟล์ใน `.claude/commands/` ตามที่ต้องการ:

- [ ] `/daily-summary` — สรุปสถานะระบบประจำวัน
- [ ] `/check-services` — เช็คสถานะบริการ (Docker, resources, network)
- [ ] `/research [หัวข้อ]` — ค้นคว้าข้อมูลจากเว็บ
- [ ] `/note [add/find/read/delete]` — จัดการโน้ต
- [ ] `/todo [add/done/list/delete]` — จัดการ TODO list
- [ ] `/quick-task [งาน]` — งานด่วนเบ็ดเตล็ด
- [ ] คำสั่งอื่นๆ ที่เหมาะกับการใช้งานของคุณ

## 4. ระบบความจำ (Memory System)

- [ ] เขียนกฎ Auto Memory ใน `CLAUDE.md` เพื่อให้ agent บันทึกเอง:
  - [ ] ข้อมูลส่วนตัว/preference → memory ประเภท `user`
  - [ ] feedback วิธีทำงาน → memory ประเภท `feedback`
  - [ ] ข้อมูลโปรเจค/งาน → memory ประเภท `project`
  - [ ] แหล่งอ้างอิง → memory ประเภท `reference`
  - [ ] สรุปเมื่อจบเซสชัน
  - [ ] งานค้างที่ยังไม่เสร็จ
- [ ] กำหนดหลักการบันทึก (เมื่อไหร่ควรจำ, เมื่อไหร่ไม่ต้อง)

## 5. เมื่อเริ่มเซสชันใหม่ (On Session Start)

- [ ] เขียนคำสั่งใน `CLAUDE.md` ให้ agent ทำอัตโนมัติเมื่อเริ่มเซสชัน:
  - [ ] ทักทาย + วันที่/เวลา
  - [ ] อ่าน memory เดิม
  - [ ] สรุปสถานะระบบ
  - [ ] เช็คงานค้าง
  - [ ] ถามว่าจะทำอะไรวันนี้

## 6. ความปลอดภัย (Security)

- [ ] ตั้งค่า deny ใน settings — ห้ามคำสั่งอันตราย (เช่น `sudo`, `su`, `rm -rf /`)
- [ ] พิจารณารันใน Docker container เพื่อ isolation
  - [ ] สร้าง `Dockerfile`
  - [ ] สร้าง `docker-compose.yml`
  - [ ] mount volume สำหรับข้อมูลที่ต้องเก็บถาวร (notes, memory)
- [ ] ไม่เก็บ secrets/credentials ในโค้ด — ใช้ environment variables

## 7. เชื่อมบริการภายนอก (MCP Servers) — ไม่บังคับ

- [ ] สร้างไฟล์ `.mcp.json` ที่ root ของโปรเจค
- [ ] เพิ่ม `enableAllProjectMcpServers: true` ใน `.claude/settings.json`
- [ ] เพิ่ม `mcp__<server>__*` ใน permissions allow list
- [ ] ตั้งค่า MCP servers ตามที่ต้องการ:
  - [ ] **server-memory** — Knowledge Graph Memory (แนะนำ) ดูตัวอย่างใน `.mcp.json`
  - [ ] Google Calendar — ดูตาราง/สร้างนัด
  - [ ] Notion / Obsidian — จัดการ notes
  - [ ] Slack — ส่ง/อ่านข้อความ
  - [ ] GitHub — จัดการ repos
  - [ ] ฐานข้อมูล (SQLite/PostgreSQL) — เก็บข้อมูลส่วนตัว
  - [ ] อื่นๆ ตามการใช้งาน

## 8. Automation (Hooks) — ไม่บังคับ

- [ ] ตั้ง hooks ใน `.claude/settings.local.json` เช่น:
  - [ ] ทำอะไรบางอย่างก่อน/หลังรันคำสั่ง
  - [ ] แจ้งเตือนเมื่อมีเหตุการณ์สำคัญ
  - [ ] auto-backup ข้อมูล

---

## Audit: ตรวจสอบ Agent ที่สร้างเสร็จแล้ว

ใช้ checklist นี้ตรวจสอบว่า agent พร้อมใช้งาน:

### ใช้งานได้จริง
- [ ] เริ่มเซสชันใหม่แล้ว agent ทักทาย + สรุปสถานะได้
- [ ] คำสั่งลัดทุกตัวใช้งานได้ (`/daily-summary`, `/note`, etc.)
- [ ] agent จำข้อมูลข้ามเซสชันได้ (ทดสอบ: บอกชื่อ → เริ่มเซสชันใหม่ → ถาม agent ว่าชื่ออะไร)
- [ ] agent วางไฟล์ถูกโฟลเดอร์ (ไม่มีไฟล์หลุดมาอยู่ root)

### ปลอดภัย
- [ ] agent ไม่สามารถรัน `sudo` หรือ `su` ได้
- [ ] agent ยืนยันก่อนลบไฟล์
- [ ] ถ้าใช้ Docker — container ไม่มีสิทธิ์เข้าถึง host โดยตรง
- [ ] ไม่มี secrets/credentials ใน repo

### ความจำ
- [ ] agent บันทึก memory อัตโนมัติเมื่อได้รับข้อมูลสำคัญ
- [ ] agent ไม่บันทึกสิ่งที่หาจากโค้ด/git ได้อยู่แล้ว
- [ ] memory ไม่หายเมื่อ restart (ถ้าใช้ Docker ต้อง mount volume)

---

> สร้างด้วย Claude Code — https://claude.com/claude-code
