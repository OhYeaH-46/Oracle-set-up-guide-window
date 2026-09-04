## 10. Multi-Oracle และการสื่อสาร

### 10.1 Oracle หลายตัว

สร้าง Oracle หลายตัวสำหรับงานต่างกัน:

```
Master Oracle (แม่)
├── Research Oracle    -- ค้นคว้า วิจัย
├── Writer Oracle      -- เขียน content
├── Code Oracle        -- เขียนโค้ด
├── Design Oracle      -- ออกแบบ visual
└── QA Oracle          -- ตรวจสอบคุณภาพ
```

### 10.2 สร้าง Oracle ลูก

จาก Parent Oracle:
```bash
/birth user/new-oracle-name
# Parent จะเตรียม context + clone repo + ส่งให้ลูกรัน /awaken
```

หรือสร้างเอง:
```bash
# สร้าง repo ใหม่
gh repo create new-oracle --private --clone
cd new-oracle
claude --dangerously-skip-permissions
/awaken
```

### 10.3 Oracle-to-Oracle Communication

```bash
# จาก Oracle A ส่งข้อความหา Oracle B
/talk-to oracle-b

# พิมพ์ข้อความ
> สวัสดี ช่วย review โค้ดนี้ให้หน่อย
```

ข้อความถูกเก็บเป็น threads ใน repo ส่งกลับไปกลับมาได้

### 10.4 Soul Sync

เมื่อ Master Oracle ได้ skill ใหม่ sync ไปให้ทุกตัว:

```bash
/soul-sync
```

**Troubleshooting**
- Q: /talk-to ส่งข้อความไม่ถึง
- A: Oracle ปลายทางต้องเปิดอยู่ใน Claude Code session ถึงจะรับได้ หรือใช้ inbox system
- Q: สร้าง Oracle กี่ตัวได้?
- A: ไม่จำกัด แต่แต่ละตัวกิน 1 Claude Code session ดูเรื่อง subscription limit ด้วย

---

