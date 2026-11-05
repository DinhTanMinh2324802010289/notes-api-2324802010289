Bài 1. Lập trình trên máy ảo đám mây đầu tiên deadline 5/11/2026
Sinh viên tự cấp phát một máy ảo đám mây trong chưa đầy 2 phút, viết API "Hello Cloud" chạy trên đó, rồi đối chiếu những gì vừa làm với 5 đặc tính điện toán đám mây của NIST. Bài gắn với Chương 1 (mục 1.2–1.5).

Mục tiêu (CELO1.1, 1.2, 1.3)

Phân biệt được việc chuẩn bị môi trường lập trình trên máy cá nhân và trên đám mây.
Nhận diện 5 đặc tính NIST qua trải nghiệm thật: tự phục vụ theo yêu cầu, truy cập mạng rộng, gộp tài nguyên, co giãn nhanh, dịch vụ đo lường được.
Dựng khung mã nguồn dùng lại cho bài 2–6.
Chuẩn bị: tài khoản GitHub; repo template tdmu-cloud-lab của giảng viên.

Các bước thực hiện
Bước 1 – Tạo repo và khởi chạy Codespace (15 phút). Mở repo template, chọn Use this template → Create a new repository, đặt tên notes-api-<MSSV>, để Public. Trong repo mới chọn Code → Codespaces → Create codespace on main. Ghi lại thời điểm bấm nút và thời điểm terminal sẵn sàng.

Bước 2 – Khởi tạo dự án Node.js (10 phút). Trong terminal của Codespace:

npm init -y
npm install express
mkdir -p src docs
Mở package.json, thêm vào mục scripts:

"start": "node src/server.js",
"test": "node --test"
Bước 3 – Viết API (25 phút). Tách ứng dụng (app.js) khỏi tệp khởi động (server.js). Cách tách này giúp bài 5 đưa được cùng ứng dụng lên nền tảng serverless mà không viết lại.

Tệp src/app.js:

const express = require('express');
const os = require('os');

const app = express();
app.use(express.json());

app.get('/', (req, res) => {
  res.json({
    message: 'Xin chào từ đám mây!',
    host: os.hostname(),
    platform: `${os.type()} ${os.release()}`,
    cpus: os.cpus().length,
    memoryGB: Number((os.totalmem() / 1024 ** 3).toFixed(1)),
    uptimeSec: Math.round(os.uptime()),
    time: new Date().toISOString()
  });
});

module.exports = app;
Tệp src/server.js:

const app = require('./app');

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`API đang chạy tại cổng ${PORT}`));
Chạy npm start. Codespaces hiện thông báo cổng 3000; chọn Open in Browser để xem JSON trả về.

Bước 4 – Truy cập từ thiết bị khác (10 phút). Mở tab Ports, nhấp chuột phải cổng 3000 → Port Visibility → Public. Mở URL dạng https://<tên>-3000.app.github.dev trên điện thoại. Sau khi thử xong, đặt lại về Private.

Bước 5 – Đo và so sánh (30 phút). Điền bảng sau vào tệp docs/index.html (bước 6). Cột "Máy cá nhân" lấy từ thông tin máy của sinh viên.

Tiêu chí	Máy cá nhân	Codespace
Thời gian từ lúc bắt đầu đến khi chạy được node -v		
Số CPU, RAM (từ API)		
Hệ điều hành		
Cách truy cập từ thiết bị khác		
Chi phí, đo bằng gì		
Để điền dòng cuối, vào Settings → Billing → Usage xem số core-giờ đã dùng.

Bước 6 – Xuất bản trang tĩnh bằng GitHub Pages (20 phút). Tạo docs/index.html chứa bảng số liệu ở bước 5 và 5 dòng ghép mỗi đặc tính NIST với một thao tác vừa làm. Commit và push:

git add .
git commit -m "Bai 1: Hello Cloud API va trang ket qua"
git push
Trong repo: Settings → Pages → Source: Deploy from a branch → main → /docs → Save. Sau khoảng 1 phút trang có địa chỉ https://<user>.github.io/notes-api-<MSSV>/.

Bước 7 – Tắt máy. Trong tab Codespaces của GitHub chọn Stop codespace.

Điểm kiểm tra
☐ GET / trả JSON có host, cpus, memoryGB
☐ URL công khai mở được từ điện thoại, sau đó đã chuyển về Private
☐ Trang GitHub Pages hiển thị bảng so sánh và 5 đặc tính NIST
Câu hỏi phản biện
Gọi GET / hai lần cách nhau một ngày (sau khi Stop rồi Start lại codespace). Trường host có đổi không? Điều đó nói gì về việc máy ảo được cấp từ một kho tài nguyên chung?
Codespaces là IaaS, PaaS hay SaaS? Lập luận bằng việc ai quản lý hệ điều hành, runtime và mã nguồn.
Nêu hai hạn chế của cách làm truyền thống (cài môi trường trên từng máy phòng lab) mà bài này đã khắc phục, và một rủi ro mới mà đám mây đưa vào.