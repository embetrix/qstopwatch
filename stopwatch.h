#ifndef STOPWATCH_H
#define STOPWATCH_H
#include <QAbstractItemModel>
#include <QTime>

class Stopwatch
{
public:
    explicit Stopwatch();
    void start();
    void pause();
    void resume();
    void reset();
    qint64 getTime();
    bool isRunning();
    void setRunning(bool running);

private:
    bool mRunning;
    qint64 mTotalTime;
    qint64 mTempTime;
    QDateTime mStartTime;
    QTime *time;

signals:

public slots:

};

#endif // STOPWATCH_H
