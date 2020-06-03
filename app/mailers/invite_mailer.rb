class InviteMailer < ApplicationMailer
  include Email::BuildEmailHelper

  def send_invite(invite)
    # Find the first group they were invited to
    first_group = invite.groups.order(:created_at).first

    # get invitee name (based on site setting)
    invitee_name = invite.invited_by.username
    if (SiteSetting.enable_names)
      invitee_name = "#{invite.invited_by.name} (#{invite.invited_by.username})"
    end

    # If they were invited to a group
    if first_group.present?
      # get group excerpt
      group_excerpt = ""
      if first_group.excerpt
        group_excerpt = first_group.excerpt.gsub("\n", " ")
      end

      build_email(invite.email,
                  template: 'invite_mailer',
                  invitee_name: invitee_name,
                  site_domain_name: Discourse.current_hostname,
                  invite_link: "#{Discourse.base_url}/invites/#{invite.invite_key}",
                  group_name: first_group.try(:name),
                  group_excerpt: group_excerpt,
                  site_description: SiteSetting.site_description,
                  site_title: SiteSetting.name)
    else
      build_email(invite.email,
                  template: 'invite_forum_mailer',
                  invitee_name: invitee_name,
                  site_domain_name: Discourse.current_hostname,
                  invite_link: "#{Discourse.base_url}/invites/#{invite.invite_key}",
                  site_description: SiteSetting.site_description,
                  site_title: SiteSetting.name)
    end

  end
end
