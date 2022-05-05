using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using XLua;
namespace Base
{
    [CSharpCallLua]
    public interface IManager
    {
        public void Awake();
        public void Start();
        public void Update();
    }
}
