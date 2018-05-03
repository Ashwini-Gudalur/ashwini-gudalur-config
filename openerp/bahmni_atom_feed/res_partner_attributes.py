from openerp.osv import fields,osv

class res_partner_attributes(osv.osv):
    _name = 'res.partner.attributes'
    _inherit = 'res.partner.attributes'

    _columns = {
        'partner_id': fields.many2one('res.partner', 'Partner', required=True, select=True, readonly=False),
        'x_caste': fields.char('Caste', size=256, required=False),
        'x_class': fields.char('Class', size=256, required=False),
        'x_cluster': fields.char('Cluster', size=256, required=False),
        'x_patientcategory': fields.char('Staff Category', size=128, required=False),
        'x_ContactNumber': fields.char('Contact Number', size=256, required=False),
        'x_debt': fields.char('Debt', size=256, required=False),
        'x_distanceFromCenter': fields.char('Distance From Center', size=256, required=False),
        'x_education': fields.char('Education', size=256, required=False),
        'x_familyIncome': fields.char('Family Income', size=256, required=False),
        'x_familyNameLocal': fields.char('Family Name Local', size=256, required=False),
        'x_givenNameLocal': fields.char('Given Name Local', size=256, required=False),
        'x_isUrban': fields.char('Is Urban', required=False),
        'x_Is_Premium_Paid': fields.char('Is Premium Paid', required=False),
        'x_Is_Sangam': fields.char('Is Sangam', required=False),
        'x_Is_Tribal': fields.char('Is Tribal', required=False),
        'x_landHolding': fields.char('Land Holding', size=256, required=False),
        'x_middleNameLocal': fields.char('Middle Name Local', size=256, required=False),
        'x_occupation': fields.char('Occupation', size=256, required=False),
        'x_primaryContact': fields.char('Primary Contact', size=256, required=False),
        'x_primaryRelative': fields.char('Primary Relative', size=256, required=False),
        'x_RationCard': fields.char('Ration Card', size=256, required=False),
        'x_secondaryContact': fields.char('Secondary Contact', size=256, required=False),
        'x_secondaryIdentifier': fields.char('Secondary Identifier', size=256, required=False),
        'x_Tribe': fields.char('Tribe', size=256, required=False),
        'x_Visiting': fields.char('Visiting', size=256, required=False)
    }




