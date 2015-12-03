using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using BusinessLogic;

namespace QL_KhoHang
{
    public partial class frmChiNhanh : Form
    {
        public frmChiNhanh()
        {
            InitializeComponent();
        }

        ChiNhanh cn = new ChiNhanh();
        int chon = 0;

        void KhoaDieuKhien()
        {
            txtTen.Enabled = txtDC.Enabled = txtSDT.Enabled = false;
            btnThem.Enabled = btnSua.Enabled = btnXoa.Enabled = true;
            btnluu.Enabled = false;
        }
        void MoDieuKhien()
        {
            txtTen.Enabled = txtDC.Enabled = txtSDT.Enabled = true;
            btnThem.Enabled = btnSua.Enabled = btnXoa.Enabled = false;
            btnluu.Enabled = true;
        }
        void SetNull()
        {
            txtTen.Text = txtMa.Text = txtDC.Text = txtSDT.Text = txtTKMa.Text = txtTKTen.Text = "";
        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            MoDieuKhien();
            SetNull();
            chon = 1;
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            MoDieuKhien();
            chon = 2;
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            if (txtMa.Text == "")
                MessageBox.Show("Chọn chi nhánh!");
            else
                if (DialogResult.Yes == MessageBox.Show("Bạn muốn xóa chi nhánh này?", "THÔNG BÁO", MessageBoxButtons.YesNo, MessageBoxIcon.Question))
                {
                    cn.XoaCN(txtMa.Text);
                    MessageBox.Show("Xóa thành công!");
                    frmChiNhanh_Load(sender, e);
                    SetNull();
                }
        }

        private void btnLuu_Click(object sender, EventArgs e)
        {
            if (chon == 1)
            {
                if (txtTen.Text == "" || txtDC.Text == "" || txtSDT.Text == "")
                    MessageBox.Show("Mời nhập đầy đủ thông tin!");
                else
                    if (DialogResult.Yes == MessageBox.Show("Bạn có muốn thêm Chi nhánh này?", "THÔNG BÁO", MessageBoxButtons.YesNo, MessageBoxIcon.Question))
                    {
                        cn.ThemChiNhanh(txtTen.Text, txtDC.Text, txtSDT.Text);
                        MessageBox.Show("Thêm thành công!");
                        SetNull();
                        frmChiNhanh_Load(sender, e);
                    }
            }
            else if (chon == 2)
            {
                if (txtTen.Text == "" || txtDC.Text == "" || txtSDT.Text == "")
                    MessageBox.Show("Mời nhập đầy đủ thông tin!");
                else
                    if (DialogResult.Yes == MessageBox.Show("Bạn có muốn Sửa Chi nhánh này?", "THÔNG BÁO", MessageBoxButtons.YesNo, MessageBoxIcon.Question))
                    {
                        cn.SuaChiNhanh(txtMa.Text, txtTen.Text, txtDC.Text, txtSDT.Text);
                        MessageBox.Show("Sửa thành công!");
                        SetNull();
                        frmChiNhanh_Load(sender, e);
                    }
            }
        }

        private void frmChiNhanh_Load(object sender, EventArgs e)
        {
            dgvChiNhanh.DataSource = cn.HienThiKhachHang();
            SetNull();
            KhoaDieuKhien();
            chon = 0;
        }

        private void btnHuy_Click(object sender, EventArgs e)
        {
            frmChiNhanh_Load(sender, e);
        }

        private void txtTKMa_TextChanged(object sender, EventArgs e)
        {
            dgvChiNhanh.DataSource = cn.TKMa(txtTKMa.Text);
        }

        private void txtTKTen_TextChanged(object sender, EventArgs e)
        {
            dgvChiNhanh.DataSource = cn.TKTenCN(txtTKTen.Text);
        }

        private void dgvChiNhanh_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            try
            {

                txtMa.Text = dgvChiNhanh.Rows[e.RowIndex].Cells[0].Value.ToString();
                txtTen.Text = dgvChiNhanh.Rows[e.RowIndex].Cells[1].Value.ToString();
                txtDC.Text = dgvChiNhanh.Rows[e.RowIndex].Cells[2].Value.ToString();
                txtSDT.Text = dgvChiNhanh.Rows[e.RowIndex].Cells[3].Value.ToString();
            }
            catch { }
        }
    }
}
