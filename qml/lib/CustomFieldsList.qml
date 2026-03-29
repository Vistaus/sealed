import "../ut_components"
import QtQuick 2.7

ConfigurationGroup {
    id: customFieldsList

    property var fields: []

    signal copyClicked(string value, string fieldName)

    function fieldSubtitle(field) {
        if (field.type === 1)
            return "";

        if (field.type === 2)
            return field.value === "true" ? i18n.tr("Yes") : i18n.tr("No");

        if (field.type === 3) {
            if (field.linked_id === 100)
                return i18n.tr("Linked: Username");

            if (field.linked_id === 101)
                return i18n.tr("Linked: Password");

            return i18n.tr("Linked field");
        }
        return field.value || "";
    }

    function fieldCopyValue(field) {
        if (field.type === 2)
            return field.value === "true" ? i18n.tr("Yes") : i18n.tr("No");

        return field.value || "";
    }

    title: i18n.tr("Custom Fields")
    visible: fields.length > 0

    Repeater {
        model: customFieldsList.fields

        delegate: DetailField {
            title: modelData.name || i18n.tr("(unnamed)")
            subtitle: fieldSubtitle(modelData)
            visibleContent: modelData.type === 1 ? (modelData.value || "") : ""
            showCopyButton: modelData.type !== 3
            showVisibilityToggle: modelData.type === 1
            isContentVisible: false
            showDivider: index < customFieldsList.fields.length - 1
            onCopyClicked: customFieldsList.copyClicked(fieldCopyValue(modelData), modelData.name || i18n.tr("Field"))
        }

    }

}
