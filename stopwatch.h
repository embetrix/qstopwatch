// SPDX-License-Identifier: GPL-3.0-or-later
/*
 * (C) Copyright 2025
 * Embetrix Embedded Systems Solutions, ayoub.zaki@embetrix.com
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; version 3 of
 * the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
 * MA 02111-1307 USA
 */

#ifndef STOPWATCH_H
#define STOPWATCH_H
#include <QObject>
#include <QTime>
#include <QTimer>

class Stopwatch : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString minutes READ minutes NOTIFY timeChanged)
    Q_PROPERTY(QString seconds READ seconds NOTIFY timeChanged)
    Q_PROPERTY(QString hundredths READ hundredths NOTIFY timeChanged)
    Q_PROPERTY(QString buttonText READ buttonText NOTIFY buttonTextChanged)
    Q_PROPERTY(bool running READ isRunning NOTIFY runningChanged)

public:
    explicit Stopwatch(QObject *parent = nullptr);
    
    Q_INVOKABLE void startStop();
    Q_INVOKABLE void reset();
    
    QString minutes() const;
    QString seconds() const;
    QString hundredths() const;
    QString buttonText() const;
    bool isRunning() const;

private slots:
    void update();

signals:
    void timeChanged();
    void buttonTextChanged();
    void runningChanged();

private:
    void start();
    void pause();
    void resume();
    void setRunning(bool running);
    qint64 getTime();
    
    bool mRunning;
    qint64 mTotalTime;
    qint64 mTempTime;
    QDateTime mStartTime;
    QTimer *mTimer;
    QString mButtonText;
};

#endif // STOPWATCH_H
