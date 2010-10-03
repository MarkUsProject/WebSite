#!/usr/bin/python

# See documentation at ~/MarkUsBot/MarkUsBot.README

import getopt
import os
import signal
import sys


HOME = os.environ['HOME']
BOT_DIR = HOME + "/MarkUsBot"
PID_FILE = BOT_DIR + "/pid.MarkUsBot"
RUN_COMMAND = "./eggdrop MarkUsBot.conf"


def bot_running():
  """Returns whether or not the bot is already running"""
  return os.path.exists(PID_FILE)


def bot_pid():
  """Returns pid of a running bot.  Returns None if
     no bot is running."""
  if not bot_running():
    return None

  pid_file_handle = open(PID_FILE)
  pid = pid_file_handle.readline().strip()

  assert pid.isdigit()

  return int(pid)


def attempt_boot():
  """Attempts to boot the bot"""
  if bot_running():
    #print "MarkUsBot already running."
    return

  print "Booting MarkUsBot..."
  os.chdir(BOT_DIR)
  os.system(RUN_COMMAND)


def attempt_kill():
  """Attempts to kill a running bot"""
  if not bot_running():
    print "MarkUsBot is not running."
    return

  pid = bot_pid()
  print "Attempting to kill the MarkUsBot (PID: %s)" % pid
  os.kill(pid, signal.SIGKILL)
  os.remove(PID_FILE)
  print "MarkUsBot should be shut down now."

def usage():
  print "usage:  ./%s options" % sys.argv[0]
  print
  print "OPTIONS:"
  print "   -h        Show this message"
  print "   -k        Kill the bot"
  print "   -r        Restart the bot"
  print
  print "Running without arguments will attempt to boot the bot."


def main():
  try:
    opts, args = getopt.getopt(sys.argv[1:], "hkr", ["help", "kill", "restart"])
  except getopt.GetoptError, err:
    print str(err)
    usage()
    sys.exit(2)

  killing = False
  starting = True
  
  for o, a in opts:
    if o == "-h":
      usage()
      sys.exit()
    elif o == "-k":
      killing = True
      starting = False
    elif o == "-r":
      killing = True
      starting = True

  if killing:
    attempt_kill()
  if starting:
    attempt_boot()


main() 
