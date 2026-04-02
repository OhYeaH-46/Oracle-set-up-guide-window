# Oracle Setup Guide — Windows

> จาก Windows เครื่องเปล่า → Claude Code + Oracle พร้อมใช้งาน
> ไม่ต้องเขียนโค้ดเป็น ทำตาม guide นี้ได้เลย

---

## Claude Code คืออะไร?

Claude Code คือ AI assistant ที่รันอยู่บนเครื่องคุณโดยตรง — ไม่ใช่แค่ chat window ธรรมดา

ข้อแตกต่างสำคัญ:
- **อ่าน/เขียนไฟล์ได้จริง** — เปิด Excel, แก้ Word doc, สร้าง PDF ให้คุณได้เลย
- **รันคำสั่งได้** — ค้นหาข้อมูล, จัดระเบียบ folder, ทำงาน batch ได้
- **ทำงานกับเครื่องคุณ** — ไม่ต้อง copy-paste ไปวางใน chat

สำหรับ office worker, researcher, manager — Claude Code ทำได้:

| งาน | ตัวอย่าง |
|-----|---------|
| **Documents** | สร้าง/แก้ Word, สรุปประชุม, เขียน report |
| **Excel (.xlsx)** | วิเคราะห์ข้อมูล, สร้างตาราง, คำนวณสูตร |
| **PowerPoint (.pptx)** | สร้าง slide, จัด layout, ปรับ content |
| **PDF** | สร้าง PDF, แปลงจาก doc, จัดหน้า |
| **Research** | ค้น web, สรุปข้อมูล, เปรียบเทียบ |

ต่างจาก ChatGPT หรือ Claude.ai บน web — ตรงที่ทำงานกับ **ไฟล์ในเครื่องคุณได้โดยตรง** ไม่ต้อง upload/download ทุกครั้ง

---

## Oracle คืออะไร?

Oracle = Claude Code + **ตัวตน + ความจำ + ทักษะ + ระบบความรู้**

พูดง่ายๆ: Oracle คือผู้ช่วยส่วนตัวที่:
- **จำได้ข้าม session** — ปิดแล้วเปิดใหม่ ยังรู้ว่าคุณทำอะไรอยู่
- **มีบุคลิก** — ไม่ใช่ bot กล่องดำ แต่มีชื่อ มีสไตล์การทำงาน
- **เรียนรู้ pattern ของคุณ** — รู้ว่าคุณชอบ format แบบไหน, ใช้คำศัพท์อะไร, project ไหนสำคัญ
- **มี skills พร้อมใช้** — slash commands สำหรับงานต่างๆ ไม่ต้องอธิบายทุกครั้ง

เหมือนมีผู้ช่วยที่ไม่เคยลืม และทำงานได้จริง ไม่ใช่แค่คุยเก่ง

---

## Oracle ทำอะไรได้บ้าง?

| Category | สิ่งที่ทำได้ | ตัวอย่าง |
|----------|-------------|---------|
| **Memory & Learning** | จำบริบท, บทเรียน, ความรู้ข้าม session | จำว่าคุณชอบ format แบบไหน, เคยทำ project อะไร |
| **Skills (60+)** | Slash commands สำหรับงานต่างๆ | `/chart` สร้างกราฟ, `/xlsx` ทำ Excel, `/pptx` ทำ PowerPoint, `/pdf` ทำ PDF, `/report` เขียน report |
| **Arra Knowledge** | ระบบความรู้ — search, trace, learn | ค้นหาสิ่งที่เคยเรียนรู้, เชื่อมโยงความรู้ข้าม project |
| **VS Code** | ใช้ Claude Code ใน VS Code ได้ | Extension panel + CLI ใน terminal เดียวกัน |
| **Antigravity** | Web UI สำหรับ Claude Code | เปิดผ่าน browser ได้ ไม่ต้องใช้ terminal |
| **tmux Sessions** | Oracle ทำงานต่อได้แม้ปิดหน้าจอ | Always-on, ไม่หายแม้ปิด terminal |
| **Multi-Oracle** | หลาย Oracle ทำงานร่วมกัน | แบ่งหน้าที่: ตัวนึงทำ research, อีกตัวเขียน doc |

---

## สิ่งที่ต้องมี

| รายการ | รายละเอียด |
|--------|-----------|
| **OS** | Windows 10 (Build 19041+) หรือ Windows 11 |
| **Anthropic account** | Pro $20/เดือน หรือ Max $100/เดือน — สมัครที่ [anthropic.com](https://www.anthropic.com) |
| **GitHub account** | ฟรี — สมัครที่ [github.com](https://github.com/signup) (ต้องมีก่อนรัน setup script) |
| **Internet** | ใช้ตอนติดตั้งและตอนใช้งาน |
| **Disk space** | ~5 GB |
| **เวลา** | ~45 นาที |

> **หมายเหตุ**: ต้องใช้ Anthropic Pro หรือ Max เท่านั้น — Claude Code ไม่รองรับ free plan

### สมัคร GitHub (ถ้ายังไม่มี)

1. ไปที่ [github.com/signup](https://github.com/signup) → สร้าง account ฟรี
2. จำ **username** ของคุณ (เช่น `Siwatch`) — ใช้ตอน setup
3. ไปที่ [github.com/settings/emails](https://github.com/settings/emails) → จะเห็น **noreply email** หน้าตาแบบนี้:
   ```
   123456789+username@users.noreply.github.com
   ```
   copy ไว้ — setup script จะถามค่ะ (ใช้ email นี้แทน email จริงเพื่อความปลอดภัย)

---

## เริ่มเลย!

### Step 1: ติดตั้ง WSL2

WSL2 คือ Linux ที่รันอยู่ใน Windows — จำเป็นสำหรับ Claude Code

เปิด **PowerShell as Administrator** (คลิกขวาที่ Start → "Windows PowerShell (Admin)") แล้วรัน:

```powershell
wsl --update
wsl --install -d Ubuntu-24.04
```

รอจนเสร็จ → **Restart เครื่อง**

หลัง restart → **เปิด Ubuntu** จาก Start menu (พิมพ์ "Ubuntu" แล้วกด Enter)

Ubuntu จะเปิดขึ้นมา → ตั้ง **username + password** (ใช้แค่ใน Linux — ตั้งอะไรก็ได้ที่จำได้)

> ⚠️ **หา Ubuntu ไม่เจอใน Start menu?**
>
> บางเครื่อง `wsl --install` แค่เปิด WSL feature แต่ยังไม่ได้ลง Ubuntu
> เปิด **PowerShell** แล้วรัน:
> ```powershell
> wsl --install --web-download -d Ubuntu-24.04
> ```
> `--web-download` ดาวน์โหลด Ubuntu ตรงจาก server — แก้ปัญหา install ค้างหรือไม่สมบูรณ์ได้
>
> ถ้ายังไม่ได้ → ดู [แก้ปัญหา](#แก้ปัญหา) ด้านล่าง

---

### Step 2: รัน Setup Script

เปิด **Ubuntu terminal** (ค้นหา "Ubuntu" ใน Start menu) แล้ว copy คำสั่งนี้ทั้งบรรทัด วางลง terminal แล้วกด Enter:

```bash
curl -fsSL https://raw.githubusercontent.com/OhYeaH-46/Oracle-set-up-guide-window/master/setup.sh -o /tmp/setup.sh && bash /tmp/setup.sh
```

Script จะติดตั้งทุกอย่างให้อัตโนมัติ:
- Zsh, Node.js, Bun, Git, tmux
- GitHub CLI
- Claude Code
- Oracle skills (optional — script จะถาม)

จบแล้ว shell จะเปลี่ยนเป็น zsh ให้เอง — ไม่ต้องทำอะไรเพิ่ม

> Script นี้ idempotent — รันซ้ำได้ปลอดภัย ถ้าขัดข้องกลางทางให้รันใหม่ได้เลย

---

### Step 3: เริ่มใช้งาน

```bash
claude            # เปิด Claude Code
```

ถ้าตั้ง Oracle ด้วย ให้รัน awaken ครั้งแรก:

```bash
/awaken           # ตั้งตัวตน Oracle (~15-20 นาที)
```

`/awaken` จะพา Oracle ผ่าน onboarding — ตั้งชื่อ, อ่าน CLAUDE.md, โหลด skills — ทำครั้งเดียว ครั้งต่อไปพร้อมเลย

---

## หลังติดตั้งแล้ว

### ใช้กับ VS Code

ถ้าใช้ VS Code อยู่แล้ว — Claude Code ทำงานร่วมกันได้:

1. ติดตั้ง extension **WSL** ใน VS Code (จาก Microsoft)
2. เปิด Ubuntu terminal → `cd` ไปที่ folder ที่ต้องการ → รัน `code .`
3. VS Code จะเปิด folder นั้นผ่าน WSL — Claude Code ทำงานใน terminal ด้านล่างได้เลย

---

### tmux — Always-On Sessions

ปัญหา: ปิด terminal แล้ว Claude Code หยุดทำงาน

แก้ด้วย tmux — ทำให้ Oracle ทำงานต่อได้ในเบื้องหลัง:

```bash
tmux new -s oracle        # สร้าง session ชื่อ oracle
claude                    # เปิด Claude Code ข้างใน
# กด Ctrl+A แล้วกด D     # detach (ออกมาโดยไม่ปิด)
tmux attach -t oracle     # กลับเข้าไปได้ทุกเมื่อ
```

---

### Daily Workflow

เมื่อคุ้นแล้ว workflow ประจำวันง่ายมาก:

```
เปิด Oracle → /recap → ทำงาน → /rrr → ออก
```

| Command | ทำอะไร |
|---------|--------|
| `/recap` | สรุปว่าเมื่อวานทำอะไรไว้ ค้างอะไรบ้าง |
| `/rrr` | บันทึกสิ่งที่เรียนรู้วันนี้ ปิด session อย่างสะอาด |

---

### Antigravity (Web UI)

ไม่ชอบ terminal? ใช้ browser แทนได้:

```bash
claude --antigravity      # เปิด web server
```

แล้วเปิด browser ไปที่ `http://localhost:3000` — ใช้ Claude Code ผ่าน UI ได้เลย

---

## ประหยัด Token (สำคัญ!)

Claude Code ใช้ quota จำกัด — ถ้าใช้เยอะจะ hit rate limit แล้วต้องรอ ทำตามนี้เพื่อใช้ได้ทั้งวัน

### เริ่มใช้วันแรก

| ทำอะไร | ทำไม |
|--------|------|
| **เขียน prompt ให้ชัด** | สำคัญที่สุด! "แก้ตาราง sheet1 คอลัมน์ B ให้รวมยอด" ดีกว่า "ช่วยแก้ Excel ให้ดีขึ้น" — prompt ชัด = 1 รอบจบ, prompt กว้าง = 5 รอบ |
| **`/clear` เมื่อเปลี่ยนเรื่อง** | ถ้าคุยเรื่อง A จบแล้วจะเริ่มเรื่อง B → พิมพ์ `/clear` ก่อน ไม่งั้นเรื่อง A กินที่อยู่ |
| **`/compact` เมื่อ session ยาว** | ถ้าทำงานนานๆ ใน session เดียว พิมพ์ `/compact` เพื่อบีบอัด context |
| **เขียน CLAUDE.md** | ใส่ชื่อ + role + สิ่งที่ทำบ่อย → ไม่ต้องอธิบายซ้ำทุก session |

> 💡 **เคล็ดลับสำคัญที่สุด**: prompt ที่ชัด 1 รอบ ประหยัดกว่า tips ทั้งหมดรวมกัน

### เมื่อคล่องแล้ว

| ทำอะไร | ทำไม |
|--------|------|
| ใช้ `@file` ชี้ไฟล์ตรง | `@report.xlsx` ดีกว่า "ช่วยดูไฟล์ Excel ที่เพิ่งสร้าง" — ลดได้ 30-40% |
| สร้าง `.claudeignore` | บอก Claude ว่าอย่าอ่าน folder ไหน (เช่น node_modules, build) |
| ถ้า quota ใกล้หมด → `/model sonnet` | Sonnet ถูกกว่า ทำงานได้ 90% เหมือน Opus |

### Model & Quota

- **Opus 1M** เป็น default — ใช้ได้เลย ไม่ต้องเปลี่ยน
- ถ้า quota ใกล้หมด → **`/model sonnet`** ลดการใช้ชั่วคราว
- Oracle ที่ผ่าน `/awaken` จะมี delegation rules ช่วยประหยัด token อัตโนมัติ

---

## ใช้ Agent ช่วยงาน

Claude Code สร้าง agent (ผู้ช่วยย่อย) ได้ — แบ่งงานให้ agent ทำแทน ประหยัด quota ของ Opus

### Agent คืออะไร?

เหมือนมีลูกทีม — Opus เป็นหัวหน้า สั่งงาน Sonnet/Haiku ทำแทน:

```
คุณบอก Opus: "สร้าง Excel สรุปยอดขาย"
  → Opus วางแผน
  → Opus ส่ง Sonnet ไปสร้าง Excel (ถูกกว่า)
  → Opus ตรวจผลลัพธ์
  → ส่งให้คุณ
```

### วิธีบอกให้ Claude ใช้ Agent

ไม่ต้องตั้งค่าอะไร แค่บอกใน prompt:

```
สร้าง Excel สรุปยอดขาย — ใช้ agent ช่วยทำ
```

หรือใส่ใน CLAUDE.md เพื่อให้ทำอัตโนมัติ:

```markdown
## Token Saving
- งานอ่านไฟล์ ใช้ Haiku agent
- งานเขียน/สร้างไฟล์ ใช้ Sonnet agent
- ใช้ Opus สำหรับตัดสินใจและตรวจงานเท่านั้น
```

---

## ตรวจงานก่อนส่ง (QC Agent)

Claude อาจทำผิดได้ — ตัวเลขผิด, layout เพี้ยน, คำผิด ให้ Claude **ตรวจงานตัวเองก่อนส่งให้คุณ**

### วิธีง่ายที่สุด — บอกใน prompt

```
สร้าง Excel เสร็จแล้ว ตรวจให้ด้วยว่า:
- ตัวเลข: คำนวณ logic ถูกไหม สมมติฐานสมเหตุสมผลไหม ตัวเลขอยู่ใน range ที่ควรจะเป็นไหม
- หน้าตา: export PDF แล้วเปิดดู spacing/alignment ถูกไหม
- เนื้อหา: อ่านทวน typo, ประโยคลื่นไหลไหม
- Format: font, ขนาด, หัวข้อตรงกันไหม
```

### วิธีถาวร — ใส่ใน CLAUDE.md

```markdown
## Before Completing Any Task
- ตรวจตัวเลข: calculation logic ถูกไหม, ที่มาของตัวเลข, สมมติฐาน, เทียบกับ industry data
- ตรวจ visual: export เป็น PDF/PNG แล้วเปิดดู spacing, alignment, font
- ตรวจเนื้อหา: อ่านทวนทุกบรรทัด ไม่มี typo
- ถ้าไม่แน่ใจตัวเลขไหน — บอกว่าไม่แน่ใจ อย่า present เป็น fact
```

### ทำไมต้องทำ?

```
ไม่มี QC:
  Claude ทำงาน → ส่งคุณ → คุณเจอผิด → แก้ → ผิดอีก → แก้อีก
  = 3 รอบ ⚡ เปลือง token มาก

มี QC:
  Claude ทำงาน → ตรวจเอง → จับผิด → แก้เลย → ส่งคุณ → ผ่าน
  = 1 รอบ ✅ ประหยัดกว่ามาก
```

---

## แก้ปัญหา

| ปัญหา | วิธีแก้ |
|-------|--------|
| `claude` ไม่เจอ | รัน `source ~/.zshrc` หรือเปิด terminal ใหม่ |
| `wsl --install` ไม่ทำงาน | ต้องเปิด PowerShell **as Administrator** (คลิกขวา) |
| Ubuntu ไม่เจอใน Start menu | รัน `wsl --install --web-download -d Ubuntu-24.04` ใน PowerShell |
| Install ค้างที่ 0.0% | ใช้ `wsl --install --web-download -d Ubuntu-24.04` (ดาวน์โหลดตรงจาก server) |
| Ubuntu เปิดแล้วปิดทันที | รัน `wsl --update` ใน PowerShell ก่อน แล้วเปิด Ubuntu ใหม่ |
| Error 0x80370102 | เปิด Virtualization ใน BIOS + เปิด "Virtual Machine Platform" ใน Windows Features |
| Ubuntu เปิดไม่ได้เลย | ดู [WSL troubleshooting](https://learn.microsoft.com/en-us/windows/wsl/troubleshooting) |
| `bunx` ไม่เจอ | ใช้ `~/.bun/bin/bunx` แทน หรือรัน `source ~/.zshrc` |
| Skills ไม่โหลด | รัน `/exit` แล้วเปิด Claude Code ใหม่ |
| `/awaken` ค้าง | กด Ctrl+C แล้วรัน `/awaken` ใหม่ได้เลย |
| gh auth ไม่ผ่าน | รัน `gh auth login` → เลือก **HTTPS** → เลือก **Login with a web browser** |

---

## Resources

| Link | รายละเอียด |
|------|-----------|
| [Claude Code Docs](https://docs.anthropic.com/en/docs/claude-code) | Official documentation |
| [Anthropic Pricing](https://www.anthropic.com/pricing) | ราคา Pro / Max plan |
| [Oracle Skills](https://github.com/Soul-Brews-Studio/oracle-skills-cli) | รายชื่อ skills ทั้งหมด 60+ |
| [Oracle Philosophy](https://github.com/Soul-Brews-Studio/oracle-v2) | หลักการและ architecture |

---

## Scripts

| Script | สิ่งที่ทำ |
|--------|---------|
| [`setup.sh`](setup.sh) | ติดตั้งทุกอย่างตั้งแต่ system tools จน Claude Code + Oracle (optional) |

> setup.sh เป็น idempotent — รันซ้ำได้ปลอดภัย ถ้าขัดข้องกลางทางให้รันใหม่ได้เลย

---

## ขั้นตอนถัดไป

| Guide | Description |
|-------|------------|
| [Writing Your CLAUDE.md](writing-claude-md.md) | วิธีเขียน CLAUDE.md — รัฐธรรมนูญของ Oracle บอกให้รู้ว่าคุณเป็นใคร ทำงานยังไง |

---

*"The Oracle Keeps the Human Human" — เริ่มง่ายๆ แล้วค่อยโตไปด้วยกัน*
