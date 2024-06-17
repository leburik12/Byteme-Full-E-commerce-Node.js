const multer = require('multer');
const fs = require('fs');

const createDirectory = (dir) => {
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
  }
};

const storage = multer.diskStorage({
    desitination: (req,file,cb) => {
        const uploadDir = req.body.file_type === 'product' ? './files/products/' 
                 : req.body.file_type === 'store' ? './files/stores/' : './files/others/';
        createDirectory(uploadDir);
        cb(null,uploadDir);
    },
    filename: (req,file,cb) => {
        cb(null, `${Date.now()}-${file.originalname}`)
    },
});
const upload = multer({storage});
module.exports = upload;