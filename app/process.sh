#!/usr/bin/env bash

process_start()
{
    heading "Starting..."
    pm2 start "${__daemon}"
    success "Start OK!"
}

process_stop()
{
    heading "Stopping..."
    pm2 stop "${__daemon}"
    success "Stop OK!"
}

process_restart()
{
    heading "Restarting..."
    pm2 restart "${__daemon}"
    success "Restart OK!"
}

process_reload()
{
    heading "Reloading..."
    pm2 reload "${__daemon}"
    success "Reload OK!"
}

process_kill()
{
    heading "Reloading..."
    pm2 delete "${__daemon}"
    success "Reload OK!"
}

process_kill()
{
    heading "Killing..."
    pm2 delete "${__daemon}"
    success "Kill OK!"
}

process_info()
{
    pm2 show "${__daemon}"
}

process_logs()
{
    pm2 logs "${__daemon}"
}
