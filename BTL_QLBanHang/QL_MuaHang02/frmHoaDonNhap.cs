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

namespace QuanLyBanHang
{
    public partial class frmHoaDonNhap : Form
    {
        public frmHoaDonNhap()
        {
            InitializeComponent();
        }

        int dong = 0;
        HoaDonNhap hd = new HoaDonNhap();
        CTHD cthd = new CTHD();
        NhaCungCap ncc = new NhaCungCap();
        private void frmHoaDonNhap_Load(object sender, EventArgs e)
        {
            HienThiHD("");
            if (dgvHDN.Rows.Count > 1)
            {
                string ma = dgvHDN.Rows[0].Cells[1].Value.ToString();
                HienThiCTHD("WHERE MaHD = '" + ma + "'");
                txtTongTien.Text = hd.TongTien(ma);
            }
            comboBox2.DataSource = ncc.ShowNCC("");
            comboBox2.DisplayMember = "TenNCC";
            comboBox2.ValueMember = "MaNCC";
            comboBox2.SelectedValue = "MaNCC";
        }
        public void HienThiHD(string DieuKien)
        {
            dgvHDN.DataSource = hd.ShowHDN(DieuKien);           
            for (int i = 0; i < dgvHDN.RowCount - 1; i++) dgvHDN.Rows[i].Cells[0].Value = (i + 1).ToString();
        }
        public void HienThiCTHD(string DieuKien)
        {
            dgvCTHD.DataSource = cthd.ShowCTHD(DieuKien);
            for (int i = 0; i < dgvCTHD.RowCount - 1; i++) dgvCTHD.Rows[i].Cells[0].Value = (i + 1).ToString();
        }

        private void dgvHDN_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            try
            {
                string ma = dgvHDN.Rows[e.RowIndex].Cells[1].Value.ToString();
                HienThiCTHD("WHERE MaHD = '" + ma + "'");
                txtTongTien.Text = hd.TongTien(ma);

                dong = e.RowIndex;
            }
            catch { }
        }

        private void btnThoat_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnThen_Click(object sender, EventArgs e)
        {
            frmThemHD frm = new frmThemHD();
            frm.Show();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBox1.SelectedIndex == 6) dateTimePicker1.Enabled = dateTimePicker2.Enabled = true;
            else dateTimePicker1.Enabled = dateTimePicker2.Enabled = false;
        }

        private void btnTK_Click(object sender, EventArgs e)
        {
            switch (comboBox1.SelectedIndex)
            {
                case -1: return;
                case 0: dgvHDN.DataSource = hd.ShowHDN(DateTime.Now.AddDays(-1), DateTime.Now); break;
                case 1: dgvHDN.DataSource = hd.ShowHDN(DateTime.Now.AddDays(-7), DateTime.Now); break;
                case 2: dgvHDN.DataSource = hd.ShowHDN(DateTime.Now.AddMonths(-1), DateTime.Now); break;
                case 3: dgvHDN.DataSource = hd.ShowHDN(DateTime.Now.AddMonths(-3), DateTime.Now); break;
                case 4: dgvHDN.DataSource = hd.ShowHDN(DateTime.Now.AddMonths(-6), DateTime.Now); break;
                case 5: dgvHDN.DataSource = hd.ShowHDN(DateTime.Now.AddYears(-1), DateTime.Now); break;
                case 6: dateTimePicker1.Enabled = dateTimePicker2.Enabled = true; dgvHDN.DataSource = hd.ShowHDN(dateTimePicker1.Value, dateTimePicker2.Value); break;
            }
            HienThiCTHD("WHERE MaHD = '1'");
            for (int i = 0; i < dgvHDN.RowCount - 1; i++) dgvHDN.Rows[i].Cells[0].Value = (i + 1).ToString();
            if (dgvHDN.Rows.Count > 1)
            {
                string ma = dgvHDN.Rows[0].Cells[1].Value.ToString();
                HienThiCTHD("WHERE MaHD = '" + ma + "'");
                txtTongTien.Text = hd.TongTien(ma);
            }
        }

        private void btnTim_Click(object sender, EventArgs e)
        {
            if (comboBox2.SelectedIndex != -1)
            {
                dataGridView1.DataSource = hd.PhieuNhap(comboBox2.SelectedValue.ToString());
                for (int i = 0; i < dataGridView1.Rows.Count - 1; i++) dataGridView1.Rows[i].Cells[0].Value = (i + 1).ToString();
            }
        }

        private void btnPrint_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Bạn Muốn In Hóa Đơn Này?", "Question", MessageBoxButtons.OK) == DialogResult.OK)
            {
                frmInHDB frm = new frmInHDB(dgvHDN.Rows[dong].Cells[1].Value.ToString(), false);
                frm.Show();
            }
        }     
    }
}
