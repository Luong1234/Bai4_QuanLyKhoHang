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
    public partial class frmThemPN : Form
    {
        public frmThemPN()
        {
            InitializeComponent();
        }

        HangHoa hh = new HangHoa();
        private void frmThemPN_Load(object sender, EventArgs e)
        {
            HienThi();
        }

        public void HienThi()
        {
            dgvSP.DataSource = hh.ShowHangHoa("");
        }
    }
}
