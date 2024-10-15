import sys
import os
import django
from pathlib import Path
from pprint import pp
from dotenv import load_dotenv
BASE_DIR = Path(os.path.abspath(__file__)).parent.parent.parent.parent
BKMONITOR_DIR = BASE_DIR / "bkmonitor"

# 添加 bk-monitor 到 sys.path
# sys.path.insert(0,str(BKMONITOR_DIR))

# 添加 bk-monitor/bkmoniotr 到 sys.path
sys.path.insert(0,str(BKMONITOR_DIR))

# 添加 bk-monitor/bkmonitor/packages 到 sys.path
sys.path.append(str(BKMONITOR_DIR / "packages"))
# pp(sys.path)
os.environ.setdefault("DJANGO_SETTINGS_MODULE","settings")

os.environ["DJANGO_ALLOW_ASYNC_UNSAFE"] = "true"

load_dotenv(str(BASE_DIR/".env"))
django.setup()


'''
import sys

sys.path.append('D:\PythonProjects\\bk-monitor\\venv2\share\scripts')
import hello
'''
