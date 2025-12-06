#include "stopwatch.h"

// Default constructor
Stopwatch::Stopwatch(QObject *parent) :
    QObject(parent),
    mRunning(false),
    mTotalTime(0),
    mTempTime(0),
    mButtonText("Start")
{
    mTimer = new QTimer(this);
    connect(mTimer, &QTimer::timeout, this, &Stopwatch::update);
    mTimer->start(10);
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
    setRunning(false);
}

// Resumes the stopwatch.
// Declares the watch to be running again.
void Stopwatch::resume()
{
    mStartTime = QDateTime::currentDateTime();
    mRunning = true;
}

// Resets the stopwatch.
// Resets the saved time and declares the watch to not be running.
void Stopwatch::reset()
{
    mTotalTime = 0;
    mButtonText = "Start";
    setRunning(false);
    emit buttonTextChanged();
    emit timeChanged();
}

// Returns whether the stopwatch is running.
bool Stopwatch::isRunning() const
{
    return mRunning;
}

// Sets the state of the stopwatch (running/not running)
void Stopwatch::setRunning(bool running)
{
    if (mRunning != running) {
        mRunning = running;
        emit runningChanged();
    }
}

// Returns the current time of the running stopwatch
qint64 Stopwatch::getTime()
{
    mTempTime = mStartTime.msecsTo(QDateTime::currentDateTime());
    qint64 time = mTotalTime + mTempTime;
    return time;
}

// QML-accessible method to start/stop the timer
void Stopwatch::startStop()
{
    if(isRunning()) {
        mButtonText = "Resume";
        emit buttonTextChanged();
        pause();
    }
    else {
        mButtonText = "Pause";
        emit buttonTextChanged();
        start();
    }
}

// Update method called by timer
void Stopwatch::update()
{
    if(isRunning())
    {
        emit timeChanged();
    }
}

// Property getters for QML
QString Stopwatch::minutes() const
{
    if(!mRunning && mTotalTime == 0)
        return "00";
    
    qint64 time = const_cast<Stopwatch*>(this)->getTime();
    int m = (time / 1000 / 60) % 60;
    
    return QString("%1").arg(m, 2, 10, QChar('0'));
}

QString Stopwatch::seconds() const
{
    if(!mRunning && mTotalTime == 0)
        return "00";
    
    qint64 time = const_cast<Stopwatch*>(this)->getTime();
    int s = (time / 1000) % 60;
    
    return QString("%1").arg(s, 2, 10, QChar('0'));
}

QString Stopwatch::hundredths() const
{
    if(!mRunning && mTotalTime == 0)
        return "00";
    
    qint64 time = const_cast<Stopwatch*>(this)->getTime();
    int ms_dis = (time / 10) % 100;
    
    return QString("%1").arg(ms_dis, 2, 10, QChar('0'));
}

QString Stopwatch::buttonText() const
{
    return mButtonText;
}
