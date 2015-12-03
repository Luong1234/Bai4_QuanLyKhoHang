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
    public partial class frmNhaCungCap : Form
    {
        public frmNhaCungCap()
        {
            InitializeComponent();
        }
        NhaCungCap ncc = new NhaCungCap();
        int chon = 0;

        private void frmNhaCungCap_Load(object sender, EventArgs e)
        {
            HienThi();
            SetNull();
            cboTK.SelectedIndex = 0;
            KhoaDieuKhien();
            chon = 0;
        }

        public void HienThi()
        {
            dataGridView1.DataSource = ncc.ShowNCC("");
            
            Init();
        }
        public void Init()
        {
            if (dataGridView1.RowCount > 1)
            {
                try
                {
                    txtMaNCC.Text = dataGridView1.Rows[0].Cells[0].Value.ToString();
                    txtTenNCC.Text = dataGridView1.Rows[0].Cells[1].Value.ToString();
                    txtDiaChi.Text = dataGridView1.Rows[0].Cells[2].Value.ToString();
                    txtSDT.Text = dataGridView1.Rows[0].Cells[3].Value.ToString();
                }
                catch { }
            }

        }
        public void SetNull()
        {
            txtTK.Text = "";
            txtMaNCC.Text = "";
            txtTenNCC.Text = "";
            txtDiaChi.Text = "";
            txtSDT.Text = "";
        }
        private void btnThem_Click(object sender, EventArgs e)
        {
            SetNull();
            cboTK.Enabled = false;
            txtTK.Enabled = false;
            btnLuu.Enabled = true;
            btnHuy.Enabled = true;
            btnThem.Enabled = false;
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            ncc.UpdateNCC(txtMaNCC.Text, txtTenNCC.Text, txtDiaChi.Text, txtSDT.Text);
            MessageBox.Show("Sửa dữ liệu thành công !!!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            HienThi();
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {

        }

        private void btnLuu_Click(object sender, EventArgs e)
        {

        }

        private void btnHuy_Click(object sender, EventArgs e)
        {
            HienThi();
            cboTK.Enabled = true;
            txtTK.Enabled = true;
            btnLuu.Enabled = false;
            btnHuy.Enabled = false;
            btnThem.Enabled = true;
        }

        private void btnThoat_Click(object sender, EventArgs e)
        {
            if(MessageBox.Show("Bạn Có Chắc Muốn Thoát Ứng Dụng Này?", "Cảnh Báo", MessageBoxButtons.YesNo)==DialogResult.Yes)
                this.Close();
        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            try
            {
                txtMaNCC.Text = dataGridView1.Rows[e.RowIndex].Cells[0].Value.ToString();
                txtTenNCC.Text = dataGridView1.Rows[e.RowIndex].Cells[1].Value.ToString();
                txtDiaChi.Text = dataGridView1.Rows[e.RowIndex].Cells[2].Value.ToString();
                txtSDT.Text = dataGridView1.Rows[e.RowIndex].Cells[3].Value.ToString();
            }
            catch { 
                
            }
        }
        public void TimKiem(string DieuKien)
        {
            dataGridView1.DataSource = ncc.ShowNCC("WHERE " + DieuKien + " LIKE N'%" + txtTK.Text + "%'");
            for (int i = 0; i < dataGridView1.RowCount - 1; i++)
            {
                dataGridView1.Rows[i].Cells[0].Value = (i + 1).ToString();
            }
        }

        private void txtTK_TextChanged(object sender, EventArgs e)
        {
            if (txtTK.Text == "") HienThi();
            else
            {
                if (cboTK.SelectedIndex == 0) TimKiem("MaNCC");
                else if (cboTK.SelectedIndex == 1) TimKiem("TenNCC");
                else if (cboTK.SelectedIndex == 2) TimKiem("DiaChi");
                else if (cboTK.SelectedIndex == 3) TimKiem("SDT");
            }
        }

        private void btnThem_Click_1(object sender, EventArgs e)
        {
            MoDieuKhien();
            SetNull();
            chon = 1;

        }
        void KhoaDieuKhien()
        {
            txtTenNCC.Enabled = txtDiaChi.Enabled = txtSDT.Enabled = false;
            btnThem.Enabled = btnSua.Enabled = btnXoa.Enabled = true;
            btnLuu.Enabled = false;
        }
        void MoDieuKhien()
        {
            txtTenNCC.Enabled = txtDiaChi.Enabled = txtSDT.Enabled = true;
            btnThem.Enabled = btnSua.Enabled = btnXoa.Enabled = false;
            btnLuu.Enabled = true;
        }

        private void btnSua_Click_1(object sender, EventArgs e)
        {
            MoDieuKhien();
            SetNull();
            chon = 2;
        }

        private void btnXoa_Click_1(object sender, EventArgs e)
        {
            if (txtMaNCC.Text == "")
                MessageBox.Show("Chọn Nhà cung cấp!");
            else
                if (DialogResult.Yes == MessageBox.Show("Bạn muốn xóa Nhà cung cấp này?", "THÔNG BÁO", MessageBoxButtons.YesNo, MessageBoxIcon.Question))
                {
                    ncc.DeleteNCC(txtMaNCC.Text);
                    MessageBox.Show("Xóa thành công!");
                    frmNhaCungCap_Load(sender, e);
                    SetNull();
                }
        }

        private void btnLuu_Click_1(object sender, EventArgs e)
        {
            if (chon == 1)
            {
                if (txtTenNCC.Text == "" || txtDiaChi.Text == "" || txtSDT.Text == "")
                    MessageBox.Show("Mời nhập đầy đủ thông tin!");
                else
                    if (DialogResult.Yes == MessageBox.Show("Bạn có muốn thêm Nhà cung cấp này?", "THÔNG BÁO", MessageBoxButtons.YesNo, MessageBoxIcon.Question))
                    {
                        ncc.InsertNCC(txtTenNCC.Text, txtDiaChi.Text, txtSDT.Text);
                        MessageBox.Show("Thêm thành công!");
                        SetNull();
                        frmNhaCungCap_Load(sender, e);
                    }
            }
            else if (chon == 2)
            {
                if (txtTenNCC.Text == "" || txtDiaChi.Text == "" || txtSDT.Text == "")
                    MessageBox.Show("Mời nhập đầy đủ thông tin!");
                else
                    if (DialogResult.Yes == MessageBox.Show("Bạn có muốn Sửa Nhà cung cấp này?", "THÔNG BÁO", MessageBoxButtons.YesNo, MessageBoxIcon.Question))
                    {
                        ncc.UpdateNCC(txtMaNCC.Text, txtTenNCC.Text, txtDiaChi.Text, txtSDT.Text);
                        MessageBox.Show("Sửa thành công!");
                        SetNull();
                        frmNhaCungCap_Load(sender, e);
                    }
            }
        }

        private void btnHuy_Click_1(object sender, EventArgs e)
        {
            frmNhaCungCap_Load(sender, e);
        }
    }
}
