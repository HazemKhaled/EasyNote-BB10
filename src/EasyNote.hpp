// Navigation pane project template
#ifndef EasyNote_HPP_
#define EasyNote_HPP_

#include <QObject>

namespace bb { namespace cascades { class Application; }}

/*!
 * @brief Application pane object
 *
 *Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class EasyNote : public QObject
{
    Q_OBJECT
public:
    EasyNote(bb::cascades::Application *app);
    virtual ~EasyNote() {}
};

#endif /* EasyNote_HPP_ */