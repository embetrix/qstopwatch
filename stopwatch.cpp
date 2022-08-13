#include "stopwatch.h"

// Default constructor
Stopwatch::Stopwatch() :
    mRunning(false),
    mTotalTime(0),
    mTempTime(0)
{
}

// Starts the stopwatch.
// Instantiates the start time and declares the watch to be running.
void Stopwatch::start()
{
    mStartTime = QDateTime::currentDateTime();
    mRunning = true;
}

// Pauses the stopwatch.
// Saves the current time and declares the watch to not be running.
void Stopwatch::pause()
{
    mTotalTime += mTempTime;
    mRunning = false;
}

// Resumes the stopwatch.
// Declares the watch to be running again.
void Stopwatch::resume()
{
    mRunning = true;
}

// Resets the stopwatch.
// Resets the saved time and declares the watch to not be running.
void Stopwatch::reset()
{
    mTotalTime = 0;
    mRunning = false;
}

// Returns whether the stopwatch is running.
bool Stopwatch::isRunning()
{
    return mRunning;
}

// Sets the state of the stopwatch (running/not running)
void Stopwatch::setRunning(bool running)
{
    mRunning = running;
}

// Returns the current time of the running stopwatch
qint64 Stopwatch::getTime()
{
    mTempTime = mStartTime.msecsTo(QDateTime::currentDateTime());
    qint64 time = mTotalTime + mTempTime;
    return time;
}
