# AI Personal Agent

PoC สำหรับสร้าง AI Personal Agent ด้วย [Claude Code](https://claude.com/claude-code)

ใช้ Claude Code เป็นผู้ช่วยส่วนตัว — จำข้อมูลข้ามเซสชัน, จัดการโน้ต, ค้นคว้า, เช็คระบบ และอื่นๆ อีกมากมาย

## เริ่มต้นใช้งาน

### รันแบบ Docker (แนะนำ)

```bash
git clone https://github.com/monthop-gmail/poc-ai-personal-agent.git
cd poc-ai-personal-agent
docker compose up -d
docker compose exec agent claude
```

### รันแบบ Local

```bash
git clone https://github.com/monthop-gmail/poc-ai-personal-agent.git
cd poc-ai-personal-agent
claude
```

## คำสั่งลัดที่มี

| คำสั่ง | ใช้ทำอะไร |
|--------|----------|
| `/daily-summary` | สรุปสถานะระบบประจำวัน |
| `/check-services` | เช็ค Docker, resources, network |
| `/research [หัวข้อ]` | ค้นคว้าข้อมูลจากเว็บ |
| `/note [add/find/read/delete]` | จัดการโน้ตส่วนตัว |
| `/todo [add/done/list/delete]` | จัดการรายการสิ่งที่ต้องทำ |
| `/quick-task [อะไรก็ได้]` | งานด่วนเบ็ดเตล็ด |

## โครงสร้างโฟลเดอร์

```
/workspace/
├── .claude/commands/   — คำสั่งลัด
├── notes/              — โน้ตส่วนตัว
├── projects/           — โปรเจคทั้งหมด
├── research/           — ผลการค้นคว้า
├── downloads/          — ไฟล์ชั่วคราว
├── scripts/            — สคริปต์ที่ใช้บ่อย
├── CLAUDE.md           — คำสั่งหลักของ agent
└── CHECKLIST.md        — คู่มือสร้าง agent ของตัวเอง
```

## ฟีเจอร์หลัก

- **Auto Memory** — agent จำข้อมูลสำคัญข้ามเซสชันโดยอัตโนมัติ
- **On Session Start** — เปิดมาก็สรุปสถานะ + งานค้างให้เลย
- **Folder Rules** — ไฟล์ไม่มัว่งเปะปะ agent รู้ว่าอะไรวางที่ไหน
- **Docker Ready** — รันใน container ปลอดภัย แยกจาก host

## อยากสร้าง Agent ของตัวเอง?

ดู [CHECKLIST.md](CHECKLIST.md) — มี checklist ทีละขั้น + audit ตรวจสอบก่อนใช้งานจริง

## License

MIT
