import multer from 'multer';
import path from 'path';
import fs from 'fs';

const uploadDir = path.join(__dirname, '..', 'uploads', 'category');
if (!fs.existsSync(uploadDir)) {
   fs.mkdirSync(uploadDir, { recursive: true });
}

const storage = multer.diskStorage({
   destination: (req, file, cb) => {
      cb(null, uploadDir);
   },
   filename: (req, file, cb) => {
      const uniqueName = Date.now() + '-' + path.basename(file.originalname);
      cb(null, uniqueName);
   },
});

const uploadCategory = multer({
   storage: storage,
   fileFilter: (req, file, cb) => {
      const filetypes = /jpeg|jpg|png|webp/;
      const extname = filetypes.test(path.extname(file.originalname).toLowerCase());
      const mimetype = filetypes.test(file.mimetype);
      if (extname && mimetype) {
         return cb(null, true);
      } else {
         cb(new Error('Chỉ chấp nhận file ảnh (jpeg, jpg, png, webp)!'));
      }
   },
});

export { uploadCategory };
